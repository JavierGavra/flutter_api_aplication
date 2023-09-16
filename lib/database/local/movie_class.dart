final String tableMovie = 'movie';

class MovieFields {
  static final List<String> values = [id, idFilm, nama];
  static const String id = '_id';
  static const String idFilm = 'idFilm';
  static const String nama = 'nama';
  static const String img = 'img';
  static const String tanggal = 'tanggal';
  static const String rating = 'rating';
}

class MovieModel {
  final int? id;
  final int idFilm;
  final String nama;
  final String img;
  final String tanggal;
  final String rating;

  MovieModel({
    this.id,
    required this.idFilm,
    required this.nama,
    required this.img,
    required this.tanggal,
    required this.rating,
  });

  static MovieModel fromJson(Map<String, Object?> json) => MovieModel(
        id: json[MovieFields.id] as int?,
        idFilm: json[MovieFields.idFilm] as int,
        nama: json[MovieFields.nama] as String,
        img: json[MovieFields.img] as String,
        tanggal: json[MovieFields.tanggal] as String,
        rating: json[MovieFields.rating] as String,
      );

  Map<String, Object?> toJson() => {
        MovieFields.id: id,
        MovieFields.idFilm: idFilm,
        MovieFields.nama: nama,
        MovieFields.img: img,
        MovieFields.tanggal: tanggal,
        MovieFields.rating: rating,
      };

  MovieModel copy(
          {int? id, int? idFilm, String? nama, String? img, String? tanggal, String? rating}) =>
      MovieModel(
          id: id ?? this.id,
          idFilm: idFilm ?? this.idFilm,
          nama: nama ?? this.nama,
          img: img ?? this.img,
          tanggal: tanggal ?? this.tanggal,
          rating: rating ?? this.rating);
}
