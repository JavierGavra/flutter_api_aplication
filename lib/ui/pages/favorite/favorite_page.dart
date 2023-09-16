import 'package:flutter/material.dart';
import 'package:tugas_flutter_3/common/constant.dart';
import 'package:tugas_flutter_3/database/local/database_helper.dart';
import 'package:tugas_flutter_3/database/local/movie_class.dart';
import 'package:tugas_flutter_3/ui/pages/detail/detail_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<MovieModel> _favoriteMovies = [];
  bool _isLoading = true;

  void _readDatabase() async {
    _favoriteMovies = await DatabaseHelper.instance.readAll();
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _readDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.favorite, color: Color.fromARGB(255, 213, 70, 70)),
            SizedBox(width: 15),
            Text("Favorite"),
          ],
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _favoriteMovies.length == 0
              ? Center(child: Text("No Data Available", style: TextStyle(color: Colors.white)))
              : RefreshIndicator(
                  onRefresh: () async {
                    setState(() => _isLoading = true);
                    _readDatabase();
                    setState(() => _isLoading = false);
                  },
                  child: ListView.builder(
                    itemCount: _favoriteMovies.length,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    itemBuilder: (context, index) {
                      final item = _favoriteMovies[index];

                      return Dismissible(
                        key: ValueKey<MovieModel>(item),
                        onDismissed: (direction) async {
                          await DatabaseHelper.instance.delete(item.idFilm);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Color.fromARGB(255, 23, 23, 23),
                              duration: Duration(seconds: 1),
                              content: Row(
                                children: [
                                  Icon(Icons.favorite_border,
                                      color: Color.fromARGB(255, 213, 70, 70), size: 18),
                                  SizedBox(width: 15),
                                  Text("Dihapus Dari Favorit"),
                                ],
                              )));
                          setState(() => _favoriteMovies.removeAt(index));
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
                                    builder: (context) => DetailPage(id: item.idFilm)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(7),
                                  child: Image.network(
                                    imageBaseUrl + item.img,
                                    height: 100,
                                    width: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.nama,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        item.tanggal,
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 163, 163, 163),
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 7),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 16,
                                            color: Color.fromARGB(255, 196, 181, 48),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            item.rating,
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 196, 181, 48),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 14),
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
                    },
                  ),
                ),
    );
  }
}
