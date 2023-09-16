import 'package:flutter/material.dart';
import 'package:tugas_flutter_3/database/local/database_helper.dart';
import 'package:tugas_flutter_3/database/local/movie_class.dart';
import 'package:tugas_flutter_3/models/movie_detail_model.dart';
import 'package:tugas_flutter_3/ui/widgets/custom_snackbar/custom_snackbar.dart';

class FavoriteButton extends StatefulWidget {
  FavoriteButton({
    Key? key,
    required this.movieDetailModel,
    required this.isFavorite,
  }) : super(key: key);
  final MovieDetailModel movieDetailModel;
  final bool isFavorite;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isOn = false;

  @override
  void initState() {
    super.initState();
    isOn = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() => isOn = !isOn);
        if (isOn) {
          await DatabaseHelper.instance.create(
            MovieModel(
              idFilm: widget.movieDetailModel.id!,
              nama: widget.movieDetailModel.title.toString(),
              img: widget.movieDetailModel.posterPath.toString(),
              tanggal: widget.movieDetailModel.releaseDate.toString(),
              rating: widget.movieDetailModel.voteAverage.toString(),
            ),
          );
          showCustomSnackBar(
            context,
            title: "Ditambahkan ke favorit",
            icon: Icon(Icons.favorite, color: Color.fromARGB(255, 213, 70, 70), size: 18),
          );
        } else {
          await DatabaseHelper.instance.delete(widget.movieDetailModel.id);
          showCustomSnackBar(
            context,
            title: "Dihapus dari favorit",
            icon: Icon(Icons.favorite_border, color: Color.fromARGB(255, 213, 70, 70), size: 18),
          );
        }
      },
      child: Container(
        height: 38,
        width: 38,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40), color: Color.fromARGB(255, 49, 49, 49)),
        child: Icon(
          isOn ? Icons.favorite : Icons.favorite_border,
          size: 20,
          color: Color.fromARGB(255, 213, 70, 70),
        ),
      ),
    );
  }
}
