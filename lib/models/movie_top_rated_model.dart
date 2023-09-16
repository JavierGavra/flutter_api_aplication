import 'package:tugas_flutter_3/models/movie_list_result_model.dart';

class MovieTopRatedModel {
  int? page;
  List<MovieResultsModel>? results;

  MovieTopRatedModel({this.page, this.results});

  MovieTopRatedModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <MovieResultsModel>[];
      json['results'].forEach((v) {
        results!.add(new MovieResultsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
