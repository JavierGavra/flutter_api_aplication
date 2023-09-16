import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:tugas_flutter_3/common/constant.dart';
import 'package:tugas_flutter_3/database/local/database_helper.dart';
import 'package:tugas_flutter_3/database/local/movie_class.dart';
import 'package:tugas_flutter_3/models/movie_similiar_movie_model.dart';
import 'package:tugas_flutter_3/models/movie_video_model.dart';
import 'package:tugas_flutter_3/services/api_services.dart';
import 'package:tugas_flutter_3/ui/widgets/custom_snackbar/custom_snackbar.dart';
import 'package:tugas_flutter_3/ui/widgets/favorite_button/favorite_button.dart';
import 'package:tugas_flutter_3/ui/widgets/film_card/film_card.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:tugas_flutter_3/models/movie_detail_model.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  MovieDetailModel? _movieDetail;
  MovieVideoModel? _movieVideo;
  MovieSimiliarMovieModel? _movieSimiliarMovie;
  bool isLoaded = false;
  bool isFavorite = false;

  void fetchApi() async {
    try {
      _movieDetail = await ApiServices().getDetailMovie(widget.id);
      _movieVideo = await ApiServices().getMovieVideo(widget.id);
      _movieSimiliarMovie = await ApiServices().getSimiliarMovie(widget.id);
      List<MovieModel> dataListMovie = await DatabaseHelper.instance.readAll();
      if (dataListMovie.any((element) => element.idFilm == widget.id)) {
        isFavorite = true;
      }

      setState(() => isLoaded = true);
    } catch (e) {
      showCustomSnackBar(context, title: e.toString());
    }
  }

  String genreList(List<Genres> genresMovie) {
    List<String> temp = [];
    for (var genreMovie in genresMovie) {
      temp.add(genreMovie.name!);
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
      body: !isLoaded
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                color: Color(0xff515151),
                child: Column(
                  children: [
                    Stack(
                      // alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          height: 270,
                          width: MediaQuery.of(context).size.width,
                          child: FittedBox(
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: "$imageBaseUrl${_movieDetail!.backdropPath}",
                            ),
                            fit: BoxFit.cover,
                            clipBehavior: Clip.hardEdge,
                          ),
                        ),
                        Container(
                          height: 277,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(8, 0, 0, 0),
                                Color.fromARGB(44, 0, 0, 0),
                                Color.fromARGB(255, 0, 0, 0),
                              ],
                            ),
                          ),
                        ),

                        // Play button
                        Positioned(
                          left: 168,
                          top: 110,
                          child: InkWell(
                            onTap: () async {
                              await launchUrl(
                                  Uri.parse("https://youtu.be/${_movieVideo!.results![0].key}"),
                                  mode: LaunchMode.externalApplication);
                            },
                            child: Container(
                              width: 58,
                              height: 58,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color.fromARGB(154, 219, 219, 219)),
                              child: Icon(
                                Icons.play_arrow_rounded,
                                color: Color(0xff423F3E),
                                size: 50,
                              ),
                            ),
                          ),
                        ),

                        // Back button
                        SafeArea(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 38,
                                  width: 38,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Color.fromARGB(108, 21, 20, 31),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.arrow_back),
                                    color: Colors.white,
                                    iconSize: 20,
                                  ),
                                ),
                                FavoriteButton(
                                  movieDetailModel: _movieDetail!,
                                  isFavorite: isFavorite,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Title
                    Container(
                      color: Color(0xff15141F),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _movieDetail!.title!.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                          SizedBox(height: 4),
                          Text(
                            _movieDetail!.originalTitle!.toString(),
                            style: TextStyle(color: Color(0xffBCBCBC), fontSize: 12),
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(Icons.timer_outlined, color: Color(0xffBCBCBC), size: 20),
                              SizedBox(width: 4),
                              Text(
                                _movieDetail!.runtime!.toString() + " Minutes",
                                style: TextStyle(color: Color(0xffBCBCBC), fontSize: 12),
                              ),
                              SizedBox(width: 40),
                              Icon(Icons.star, color: Color(0xffBCBCBC), size: 20),
                              SizedBox(width: 4),
                              Text(
                                _movieDetail!.voteAverage!.toString(),
                                style: TextStyle(color: Color(0xffBCBCBC), fontSize: 12),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 1),

                    // short info
                    Container(
                      color: Color(0xff15141F),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Release Date",
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              SizedBox(height: 9),
                              Text(
                                _movieDetail!.releaseDate!.toString(),
                                style: TextStyle(color: Color(0xffBCBCBC), fontSize: 12),
                              ),
                            ],
                          ),
                          SizedBox(width: 80),
                          SizedBox(
                            width: 180,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Genre",
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                                SizedBox(height: 9),
                                Text(
                                  _movieDetail!.genres!.isEmpty
                                      ? "None"
                                      : genreList(_movieDetail!.genres!),
                                  style: TextStyle(color: Color(0xffBCBCBC), fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 1),

                    // sinopsis
                    Container(
                      color: Color(0xff15141F),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Synopsis",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(height: 9),
                          Text(
                            _movieDetail!.overview!.toString(),
                            style: TextStyle(color: Color(0xffBCBCBC), fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 1),

                    // Similiar movie
                    Container(
                      color: Color(0xff15141F),
                      padding: EdgeInsets.symmetric(horizontal: 11, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "If you like ${_movieDetail!.title!}",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 170,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _movieSimiliarMovie!.results!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 13),
                                  child: FilmCard(
                                    gambar:
                                        _movieSimiliarMovie!.results![index].posterPath.toString(),
                                    judul: _movieSimiliarMovie!.results![index].title.toString(),
                                    penonton:
                                        _movieSimiliarMovie!.results![index].popularity.toString(),
                                    rating:
                                        _movieSimiliarMovie!.results![index].voteAverage.toString(),
                                    tujuan: DetailPage(
                                        id: _movieSimiliarMovie!.results![index].id!.toInt()),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
