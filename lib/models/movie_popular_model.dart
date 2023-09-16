import 'package:tugas_flutter_3/models/movie_list_result_model.dart';

class MoviePopularModel {
  int? page;
  List<MovieResultsModel>? results;
  int? totalPages;
  int? totalResults;

  MoviePopularModel({this.page, this.results, this.totalPages, this.totalResults});

  MoviePopularModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <MovieResultsModel>[];
      json['results'].forEach((v) {
        results!.add(new MovieResultsModel.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    return data;
  }
}
