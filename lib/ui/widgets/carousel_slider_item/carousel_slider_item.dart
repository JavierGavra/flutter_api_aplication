import 'package:flutter/material.dart';
import 'package:tugas_flutter_3/common/constant.dart';
import 'package:tugas_flutter_3/ui/pages/detail/detail_page.dart';

class CarouselSliderItem extends StatelessWidget {
  CarouselSliderItem({
    Key? key,
    required this.id,
    required this.gambar,
    required this.judul,
    required this.genre,
    required this.reting,
  }) : super(key: key);
  final int id;
  final String gambar, judul, genre, reting;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: (() =>
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(id: id)))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Container(
                height: 180,
                child: FadeInImage.assetNetwork(
                  placeholder: "images/loading1.gif",
                  image: gambar == "null" ? nullImageUrl : imageBaseUrl + gambar,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              judul,
              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
