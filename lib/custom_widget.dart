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
        duration: Duration(seconds: 4),
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

// Button Like
class LikeButton extends StatefulWidget {
  const LikeButton({Key? key}) : super(key: key);

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isOn = !isOn;
        });
        if (isOn) {
          Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Color.fromARGB(255, 23, 23, 23),
              duration: Duration(seconds: 1),
              content: Row(
                children: [
                  Icon(Icons.thumb_up, color: Colors.white, size: 18),
                  SizedBox(width: 15),
                  Text("Terimakasih masukannya"),
                ],
              )));
        }
      },
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Color.fromARGB(255, 49, 49, 49)),
        child: Icon(
          isOn ? Icons.thumb_up_alt : Icons.thumb_up_outlined,
          size: 20,
          color: Color.fromARGB(255, 212, 212, 212),
        ),
      ),
    );
  }
}

// Button Dislike
class DislikeButton extends StatefulWidget {
  const DislikeButton({Key? key}) : super(key: key);

  @override
  State<DislikeButton> createState() => _DislikeButtonState();
}

class _DislikeButtonState extends State<DislikeButton> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isOn = !isOn;
        });
        if (isOn) {
          Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Color.fromARGB(255, 23, 23, 23),
              duration: Duration(seconds: 1),
              content: Row(
                children: [
                  Icon(Icons.thumb_down, color: Colors.white, size: 18),
                  SizedBox(width: 15),
                  Text("Terimakasih masukannya"),
                ],
              )));
        }
      },
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Color.fromARGB(255, 49, 49, 49)),
        child: Icon(
          isOn ? Icons.thumb_down_alt : Icons.thumb_down_outlined,
          size: 20,
          color: Color.fromARGB(255, 212, 212, 212),
        ),
      ),
    );
  }
}

// Button Favorite
class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isOn = !isOn;
        });
        if (isOn) {
          Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Color.fromARGB(255, 23, 23, 23),
              duration: Duration(seconds: 1),
              content: Row(
                children: [
                  Icon(Icons.favorite,
                      color: Color.fromARGB(255, 213, 70, 70), size: 18),
                  SizedBox(width: 15),
                  Text("Ditambahkan ke Favorit"),
                ],
              )));
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
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
        }
      },
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Color.fromARGB(255, 49, 49, 49)),
        child: Icon(
          isOn ? Icons.favorite : Icons.favorite_border,
          size: 20,
          color: Color.fromARGB(255, 213, 70, 70),
        ),
      ),
    );
  }
}

// Banner Item
class BannerItem extends StatelessWidget {
  BannerItem(
      {Key? key,
      required this.gambar,
      required this.judul,
      required this.genre,
      required this.reting})
      : super(key: key);
  String gambar, judul, genre, reting;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              height: 180,
              child: Image.asset(gambar,
                  fit: BoxFit.cover, width: MediaQuery.of(context).size.width),
            ),
          ),
          SizedBox(height: 8),
          Text(
            judul,
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                genre,
                style: TextStyle(
                  color: Color.fromARGB(255, 175, 175, 175),
                  fontSize: 10,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.star,
                    size: 11,
                    color: Color.fromARGB(255, 196, 181, 48),
                  ),
                  SizedBox(width: 2),
                  Text(
                    reting,
                    style: TextStyle(
                      color: Color.fromARGB(255, 196, 181, 48),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
