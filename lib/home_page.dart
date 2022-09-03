import 'package:flutter/material.dart';
import 'package:tugas_flutter_3/API/movie_api_popular.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_flutter_3/API/movie_api_recommend.dart';
import 'dart:convert';
import 'package:tugas_flutter_3/custom_widget.dart';
import 'package:tugas_flutter_3/API/movie_api_upcoming.dart';
import 'package:tugas_flutter_3/detail_movie.dart';
import 'package:tugas_flutter_3/main_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MovieApiPopular? movieApiPopular;
  MovieApiUpcoming? movieApiUpcoming;
  MovieApiRecommend? movieApiRecommend;
  double _stackBox = 250;
  bool isLoadedApi = false;

  void getAllListMovie() async {
    final resPopular = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=57ca7b15d5117ce1e2f3ca7e317f1e80&language=en-US&page=1"));
    final resUpcoming = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/upcoming?api_key=57ca7b15d5117ce1e2f3ca7e317f1e80&language=en-US&page=1"));
    final resRecommend = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/361743/recommendations?api_key=57ca7b15d5117ce1e2f3ca7e317f1e80&language=en-US&page=1"));
    movieApiPopular =
        MovieApiPopular.fromJson(json.decode(resPopular.body.toString()));
    movieApiUpcoming =
        MovieApiUpcoming.fromJson(json.decode(resUpcoming.body.toString()));
    movieApiRecommend =
        MovieApiRecommend.fromJson(json.decode(resRecommend.body.toString()));
    setState(() {
      isLoadedApi = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllListMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoadedApi
          ? CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text("JMDB"),
                  centerTitle: true,
                  leading: Icon(Icons.menu),
                  floating: true,
                  snap: true,
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    // Popular List
                    Stack(
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
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Popular",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  Icon(
                                    Icons.arrow_right,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              height: 170,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 13),
                                      child: FilmCard(
                                        gambar: movieApiPopular!
                                            .results![index].posterPath
                                            .toString(),
                                        judul: movieApiPopular!
                                            .results![index].title
                                            .toString(),
                                        penonton: movieApiPopular!
                                            .results![index].popularity
                                            .toString(),
                                        rating: movieApiPopular!
                                            .results![index].voteAverage
                                            .toString(),
                                        tujuan: DetailMovie(
                                            id: movieApiPopular!
                                                .results![index].id!
                                                .toInt()),
                                      ),
                                    );
                                  },
                                  itemCount: movieApiPopular!.results!.length),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),

                    // Upcoming List
                    Stack(alignment: AlignmentDirectional.center, children: [
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
                                Text(
                                  "Upcoming",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            height: 170,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13),
                                    child: FilmCard(
                                      gambar: movieApiUpcoming!
                                          .results![index].posterPath
                                          .toString(),
                                      judul: movieApiUpcoming!
                                          .results![index].title
                                          .toString(),
                                      penonton: movieApiUpcoming!
                                          .results![index].releaseDate
                                          .toString(),
                                      rating: movieApiUpcoming!
                                          .results![index].voteAverage
                                          .toString(),
                                      tujuan: DetailMovie(
                                          id: movieApiUpcoming!
                                              .results![index].id!
                                              .toInt()),
                                    ),
                                  );
                                },
                                itemCount: movieApiPopular!.results!.length),
                          ),
                        ],
                      ),
                    ]),
                    SizedBox(height: 30),

                    // Recommended List
                    Stack(alignment: AlignmentDirectional.center, children: [
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
                                Text(
                                  "Recommended",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            height: 170,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13),
                                    child: FilmCard(
                                      gambar: movieApiRecommend!
                                          .results![index].posterPath
                                          .toString(),
                                      judul: movieApiRecommend!
                                          .results![index].title
                                          .toString(),
                                      penonton: movieApiRecommend!
                                          .results![index].releaseDate
                                          .toString(),
                                      rating: movieApiRecommend!
                                          .results![index].voteAverage
                                          .toString(),
                                      tujuan: DetailMovie(
                                          id: movieApiRecommend!
                                              .results![index].id!
                                              .toInt()),
                                    ),
                                  );
                                },
                                itemCount: movieApiPopular!.results!.length),
                          ),
                        ],
                      ),
                    ]),
                  ]),
                ),
                SliverToBoxAdapter(
                  child: Container(
                      height: MediaQuery.of(context).size.height / 2 / 2),
                )
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
