import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tugas_flutter_3/API/movie_api_detail.dart';

class DetailMovie extends StatefulWidget {
  DetailMovie({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<DetailMovie> createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  MovieApiDetail? movieApiDetail;
  bool isLoaded = false;

  void getAllListMovie() async {
    final resPopular = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/${widget.id.toString()}?api_key=57ca7b15d5117ce1e2f3ca7e317f1e80&language=en-US"));
    movieApiDetail =
        MovieApiDetail.fromJson(json.decode(resPopular.body.toString()));
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
          ? Container(
              color: Color(0xff423F3E),
              child: Column(
                children: [
                  Stack(alignment: AlignmentDirectional.center, children: [
                    Container(
                      height: 270,
                      width: MediaQuery.of(context).size.width,
                      child: FittedBox(
                        child: Image.network("https://themoviedb.org/t/p/w500" +
                            movieApiDetail!.backdropPath!.toString()),
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
                            Color.fromARGB(221, 0, 0, 0),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (() {}),
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
                    )
                  ]),
                  Container(
                    color: Color(0xff15141F),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(24),
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
                          style:
                              TextStyle(color: Color(0xffBCBCBC), fontSize: 12),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              color: Color(0xffBCBCBC),
                              size: 20,
                            ),
                            SizedBox(width: 4),
                            Text(
                              movieApiDetail!.runtime!.toString() + " Minutes",
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
                  SizedBox(height: 2),
                  Container(
                    color: Color(0xff15141F),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(24),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Release",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            SizedBox(height: 9),
                            Text(
                              "Belum ada tampilan",
                              style: TextStyle(
                                  color: Color(0xffBCBCBC), fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2),
                  Container(
                    color: Color(0xff15141F),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(24),
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
                          style:
                              TextStyle(color: Color(0xffBCBCBC), fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
