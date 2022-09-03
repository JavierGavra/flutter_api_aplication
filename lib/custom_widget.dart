import 'package:flutter/material.dart';

// Card film
class FilmCard extends StatelessWidget {
  FilmCard(
      {Key? key,
      required this.gambar,
      required this.judul,
      required this.penonton,
      required this.rating,
      required this.tujuan})
      : super(key: key);
  String gambar, judul, penonton, rating;
  Widget tujuan;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => tujuan));
      }),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Container(
          height: 170,
          width: 116,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: FittedBox(
                  child: FadeInImage.assetNetwork(
                      placeholder: "images/loading1.gif",
                      image: "https://themoviedb.org/t/p/w500" + gambar),
                  fit: BoxFit.cover,
                  clipBehavior: Clip.hardEdge,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(4),
                  height: 58,
                  width: double.infinity,
                  color: Color.fromARGB(201, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              judul,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 213, 213, 213),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 1),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              penonton,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color.fromARGB(255, 175, 175, 175),
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.star,
                            size: 10,
                            color: Color.fromARGB(255, 196, 181, 48),
                          ),
                          SizedBox(width: 4),
                          Text(
                            rating,
                            style: TextStyle(
                              color: Color.fromARGB(255, 196, 181, 48),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Bottomappbar
class CustomBottomBar extends StatefulWidget {
  bool animate;
  final int index;
  final ValueChanged<int> onChangedTab;

  CustomBottomBar(
      {Key? key,
      required this.animate,
      required this.index,
      required this.onChangedTab})
      : super(key: key);

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8,
      color: Color(0xff2B2B2B),
      child: AnimatedContainer(
        duration: Duration(seconds: 3),
        curve: Curves.fastOutSlowIn,
        height: widget.animate ? 52 : 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TabBarIcon(index: 0, icon: Icon(Icons.home)),
            TabBarIcon(index: 1, icon: Icon(Icons.favorite)),
          ],
        ),
      ),
    );
  }

  Widget TabBarIcon({
    required int index,
    required Icon icon,
  }) {
    final isSelected = index == widget.index;

    return IconTheme(
      data: IconThemeData(
        color: isSelected ? Colors.white : Color.fromARGB(255, 163, 163, 163),
      ),
      child: IconButton(
        onPressed: () {
          widget.onChangedTab(index);
        },
        icon: icon,
        iconSize: 26,
      ),
    );
  }
}
