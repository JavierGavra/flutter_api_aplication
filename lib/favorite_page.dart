import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.favorite,
              color: Color.fromARGB(255, 213, 70, 70),
            ),
            SizedBox(width: 15),
            Text("Favorite"),
          ],
        ),
      ),
      body: Center(
          child: Text(
        "This page is Empty",
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}
