import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';
import 'package:tugas_flutter_3/API/movie_api_similiar_movie.dart';
import 'package:tugas_flutter_3/API/movie_api_video.dart';
import 'package:tugas_flutter_3/database/database_helper.dart';
import 'package:tugas_flutter_3/database/movie_class.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

import 'package:tugas_flutter_3/API/movie_api_detail.dart';
import 'package:tugas_flutter_3/custom_widget.dart';

class DetailMovie extends StatefulWidget {
  DetailMovie({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<DetailMovie> createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  MovieApiDetail? movieApiDetail;
  MovieApiVideo? _movieApiVideo;
  MovieApiSimiliarMovie? _movieApiSimiliarMovie;
  List<MovieModel>? dataListMovie;
  bool isLoaded = false;

  void getAllListMovie() async {
    final resDetail = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/${widget.id.toString()}?api_key=57ca7b15d5117ce1e2f3ca7e317f1e80&language=en-US"));
    final resVideo = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/${widget.id.toString()}/videos?api_key=57ca7b15d5117ce1e2f3ca7e317f1e80&language=en-US"));
    final resSimiliar = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/${widget.id.toString()}/similar?api_key=57ca7b15d5117ce1e2f3ca7e317f1e80&language=en-US&page=1"));
    movieApiDetail =
        MovieApiDetail.fromJson(json.decode(resDetail.body.toString()));
    _movieApiVideo =
        MovieApiVideo.fromJson(json.decode(resVideo.body.toString()));
    _movieApiSimiliarMovie = MovieApiSimiliarMovie.fromJson(
        json.decode(resSimiliar.body.toString()));
    dataListMovie = await DatabaseHelper.instance.readAll();
    setState(() {
      isLoaded = true;
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
      body: isLoaded
          ? SingleChildScrollView(
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
                              image: "https://themoviedb.org/t/p/w500" +
                                  movieApiDetail!.backdropPath!.toString(),
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
                                  Uri.parse("https://youtu.be/" +
                                      _movieApiVideo!.results![0].key
                                          .toString()),
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
                          child: Container(
                            margin: EdgeInsets.all(8),
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
                        ),
                      ],
                    ),

                    // Title
                    Container(
                      color: Color(0xff15141F),
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movieApiDetail!.title!.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                          SizedBox(height: 4),
                          Text(
                            movieApiDetail!.originalTitle!.toString(),
                            style: TextStyle(
                                color: Color(0xffBCBCBC), fontSize: 12),
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                color: Color(0xffBCBCBC),
                                size: 20,
                              ),
                              SizedBox(width: 4),
                              Text(
                                movieApiDetail!.runtime!.toString() +
                                    " Minutes",
                                style: TextStyle(
                                    color: Color(0xffBCBCBC), fontSize: 12),
                              ),
                              SizedBox(width: 40),
                              Icon(
                                Icons.star,
                                color: Color(0xffBCBCBC),
                                size: 20,
                              ),
                              SizedBox(width: 4),
                              Text(
                                movieApiDetail!.voteAverage!.toString(),
                                style: TextStyle(
                                    color: Color(0xffBCBCBC), fontSize: 12),
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
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Release Date",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              SizedBox(height: 9),
                              Text(
                                movieApiDetail!.releaseDate!.toString(),
                                style: TextStyle(
                                    color: Color(0xffBCBCBC), fontSize: 12),
                              ),
                            ],
                          ),
                          SizedBox(width: 80),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Genre",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              SizedBox(height: 9),
                              Container(
                                child: Text(
                                  movieApiDetail!.genres![0].name.toString(),
                                  style: TextStyle(
                                      color: Color(0xffBCBCBC), fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 1),

                    // sinopsis
                    Container(
                      color: Color(0xff15141F),
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Synopsis",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(height: 9),
                          Text(
                            movieApiDetail!.overview!.toString(),
                            style: TextStyle(
                                color: Color(0xffBCBCBC), fontSize: 13),
                          ),
                          SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FavoriteButton(
                                idFilm: movieApiDetail!.id!.toString(),
                                nama: movieApiDetail!.title!.toString(),
                                img: "https://themoviedb.org/t/p/w500" +
                                    movieApiDetail!.posterPath!.toString(),
                                tanggal:
                                    movieApiDetail!.releaseDate!.toString(),
                                rating: movieApiDetail!.voteAverage!.toString(),
                                dataListMovie: dataListMovie!.toList(),
                              ),
                              LikeButton(),
                              DislikeButton(),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 1),

                    // Similiar movie
                    Container(
                      color: Color(0xff15141F),
                      padding:
                          EdgeInsets.symmetric(horizontal: 11, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "If you like " + movieApiDetail!.title!,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 170,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13),
                                    child: FilmCard(
                                      gambar: _movieApiSimiliarMovie!
                                          .results![index].posterPath
                                          .toString(),
                                      judul: _movieApiSimiliarMovie!
                                          .results![index].title
                                          .toString(),
                                      penonton: _movieApiSimiliarMovie!
                                          .results![index].popularity
                                          .toString(),
                                      rating: _movieApiSimiliarMovie!
                                          .results![index].voteAverage
                                          .toString(),
                                      tujuan: DetailMovie(
                                          id: _movieApiSimiliarMovie!
                                              .results![index].id!
                                              .toInt()),
                                    ),
                                  );
                                },
                                itemCount:
                                    _movieApiSimiliarMovie!.results!.length),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
