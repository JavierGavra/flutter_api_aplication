import 'package:flutter/material.dart';
import 'package:tugas_flutter_3/models/genre_movie_list_model.dart';
import 'package:tugas_flutter_3/ui/pages/favorite/favorite_page.dart';
import 'package:tugas_flutter_3/models/movie_list_result_model.dart';
import 'package:tugas_flutter_3/models/movie_popular_model.dart';
import 'package:tugas_flutter_3/models/movie_top_rated_model.dart';
import 'package:tugas_flutter_3/ui/widgets/carousel_slider_item/carousel_slider_item.dart';
import 'package:tugas_flutter_3/models/movie_upcoming_model.dart';
import 'package:tugas_flutter_3/ui/pages/detail/detail_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tugas_flutter_3/services/api_services.dart';
import 'package:tugas_flutter_3/ui/widgets/custom_snackbar/custom_snackbar.dart';
import 'package:tugas_flutter_3/ui/widgets/film_card/film_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MoviePopularModel? _moviePopularListModel;
  MovieTopRatedModel? _movieTopRatedModel;
  MovieUpcomingModel? _movieUpcomingListModel;
  GenreMovieListModel? _genreMovieListModel;
  double _stackBox = 250;
  bool isApiLoaded = false;

  void fetchApi() async {
    try {
      _moviePopularListModel = await ApiServices().getPopularListMovie();
      _movieTopRatedModel = await ApiServices().getTopRatedListMovie();
      _movieUpcomingListModel = await ApiServices().getUpcomingListMovie();
      _genreMovieListModel = await ApiServices().getGenreMovieList();
      setState(() => isApiLoaded = true);
    } catch (e) {
      showCustomSnackBar(context, title: e.toString());
    }
  }

  String genreList(List<int> genresMovieId) {
    List<String> temp = [];
    for (var genreMovieId in genresMovieId) {
      for (var genre in _genreMovieListModel!.genres!) {
        if (genre.id == genreMovieId) {
          temp.add(genre.name!);
          break;
        }
      }
    }
    return temp.join(', ');
  }

  @override
  void initState() {
    super.initState();
    fetchApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !isApiLoaded
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text("JMDB"),
                  actions: [
                    IconButton(
                        icon: Icon(Icons.favorite),
                        onPressed: () => Navigator.push(
                            context, MaterialPageRoute(builder: (context) => FavoritePage())))
                  ],
                  floating: true,
                  snap: true,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 280,
                        color: Color.fromARGB(255, 23, 23, 23),
                        child: CarouselSlider(
                          options: CarouselOptions(
                              autoPlay: true, autoPlayInterval: Duration(seconds: 3)),
                          items: List.generate(
                            3,
                            (index) {
                              final item = _moviePopularListModel!.results![index];
                              return CarouselSliderItem(
                                id: item.id!,
                                gambar: item.backdropPath!,
                                judul: item.title!,
                                genre: item.genreIds!.isEmpty ? "" : genreList(item.genreIds!),
                                reting: "6.8",
                              );
                            },
                            growable: false,
                          ),
                        ),
                      ),
                      _buildListSection(
                        title: "Popular",
                        movieResults: _moviePopularListModel!.results!,
                      ),
                      SizedBox(height: 30),
                      _buildListSection(
                        title: "Upcoming",
                        movieResults: _movieUpcomingListModel!.results!,
                      ),
                      SizedBox(height: 30),
                      _buildListSection(
                        title: "Top rated",
                        movieResults: _movieTopRatedModel!.results!,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(height: MediaQuery.of(context).size.height / 2 / 2 / 2 / 2),
                )
              ],
            ),
    );
  }

  Widget _buildListSection({required String title, required List<MovieResultsModel> movieResults}) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: _stackBox,
          color: Color.fromARGB(255, 23, 23, 23),
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
                  Icon(Icons.arrow_right, color: Colors.white),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 170,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movieResults.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: FilmCard(
                      gambar: movieResults[index].posterPath.toString(),
                      judul: movieResults[index].title.toString(),
                      penonton: movieResults[index].releaseDate.toString(),
                      rating: movieResults[index].voteAverage.toString(),
                      tujuan: DetailPage(id: movieResults[index].id!.toInt()),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
