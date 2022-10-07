import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tugas_flutter_3/database/database_helper.dart';
import 'package:tugas_flutter_3/database/movie_class.dart';
import 'package:tugas_flutter_3/detail_movie.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<MovieModel> dataListMovie = [];
  bool isLoading = true;
  int id = 0;

  void bacaDatabase() async {
    dataListMovie = await DatabaseHelper.instance.readAll();
    print("Length List " + dataListMovie.length.toString());
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bacaDatabase();
  }

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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : dataListMovie.length == 0
              ? Center(
                  child: Text(
                    "No Data Available",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : ListView.builder(
                  itemCount: dataListMovie.length,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: ((context, index) {
                    final item = dataListMovie[index];
                    return Dismissible(
                      key: ValueKey<MovieModel>(item),
                      onDismissed: (direction) async {
                        await DatabaseHelper.instance
                            .delete(int.parse(item.idFilm));
                        print("${item.nama} Dihapus dari Database");
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Color.fromARGB(255, 23, 23, 23),
                            duration: Duration(seconds: 1),
                            content: Row(
                              children: [
                                Icon(Icons.favorite_border,
                                    color: Color.fromARGB(255, 213, 70, 70),
                                    size: 18),
                                SizedBox(width: 15),
                                Text("Dihapus Dari Favorit"),
                              ],
                            )));
                        setState(() {
                          dataListMovie.removeAt(index);
                        });
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        child: Row(
                          children: [
                            Icon(Icons.cancel),
                            Spacer(),
                            Icon(Icons.cancel),
                          ],
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailMovie(id: int.parse(item.idFilm))));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: Image.network(
                                  item.img,
                                  height: 100,
                                  width: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.nama,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    item.tanggal,
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 163, 163, 163),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 7),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 16,
                                        color:
                                            Color.fromARGB(255, 196, 181, 48),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        item.rating,
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 196, 181, 48),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 14),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 49, 49, 49),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
    );
  }
}
