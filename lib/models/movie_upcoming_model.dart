import 'package:tugas_flutter_3/models/movie_list_result_model.dart';

class MovieUpcomingModel {
  Dates? dates;
  int? page;
  List<MovieResultsModel>? results;
  int? totalPages;
  int? totalResults;

  MovieUpcomingModel({this.dates, this.page, this.results, this.totalPages, this.totalResults});

  MovieUpcomingModel.fromJson(Map<String, dynamic> json) {
    dates = json['dates'] != null ? new Dates.fromJson(json['dates']) : null;
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
    if (this.dates != null) {
      data['dates'] = this.dates!.toJson();
    }
    data['page'] = this.page;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    return data;
  }
}

class Dates {
  String? maximum;
  String? minimum;

  Dates({this.maximum, this.minimum});

  Dates.fromJson(Map<String, dynamic> json) {
    maximum = json['maximum'];
    minimum = json['minimum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maximum'] = this.maximum;
    data['minimum'] = this.minimum;
    return data;
  }
}
