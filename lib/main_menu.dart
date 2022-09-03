import 'package:flutter/material.dart';
import 'package:tugas_flutter_3/API/movie_api_popular.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_flutter_3/API/movie_api_recommend.dart';
import 'dart:convert';
import 'package:tugas_flutter_3/custom_widget.dart';
import 'package:tugas_flutter_3/API/movie_api_upcoming.dart';
import 'package:tugas_flutter_3/detail_movie.dart';
import 'package:tugas_flutter_3/favorite_page.dart';
import 'package:tugas_flutter_3/home_page.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  MovieApiPopular? movieApiPopular;
  MovieApiUpcoming? movieApiUpcoming;
  MovieApiRecommend? movieApiRecommend;
  bool isLoaded = false;
  int index = 0;

  final pages = <Widget>[
    HomePage(),
    FavoritePage(),
  ];

  void getHomePage() async {
    final resPopular = await HomePage();
    setState(() {
      isLoaded = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHomePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: CustomBottomBar(
        animate: isLoaded,
        index: index,
        onChangedTab: onChangedTab,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color.fromARGB(255, 39, 104, 157),
        child: Icon(
          Icons.search,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void onChangedTab(int index) {
    setState(() {
      this.index = index;
    });
  }
}
