import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tugas_flutter_3/common/constant.dart';
import 'package:tugas_flutter_3/models/genre_movie_list_model.dart';
import 'package:tugas_flutter_3/models/movie_detail_model.dart';
import 'package:tugas_flutter_3/models/movie_popular_model.dart';
import 'package:tugas_flutter_3/models/movie_similiar_movie_model.dart';
import 'package:tugas_flutter_3/models/movie_top_rated_model.dart';
import 'package:tugas_flutter_3/models/movie_upcoming_model.dart';
import 'package:tugas_flutter_3/models/movie_video_model.dart';

class ApiServices {
  final _apiKey = "?api_key=57ca7b15d5117ce1e2f3ca7e317f1e80";

  Future getPopularListMovie() async {
    final endPoint = "/movie/popular";
    final params = "&language=en-US&page=1";
    final url = Uri.parse("$baseUrl$endPoint$_apiKey$params");

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return MoviePopularModel.fromJson(jsonDecode(response.body));
      } else {
        throw failApiMessage;
      }
    } on SocketException {
      throw "No internet connection";
    } catch (e) {
      throw apiErrorMessage;
    }
  }

  Future getTopRatedListMovie() async {
    final endPoint = "/movie/top_rated";
    final params = "&language=en-US&page=1";
    final url = Uri.parse("$baseUrl$endPoint$_apiKey$params");

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return MovieTopRatedModel.fromJson(jsonDecode(response.body));
      } else {
        throw failApiMessage;
      }
    } on SocketException {
      throw "No internet connection";
    } catch (e) {
      throw apiErrorMessage;
    }
  }

  Future getUpcomingListMovie() async {
    final endPoint = "/movie/upcoming";
    final params = "&language=en-US&page=1";
    final url = Uri.parse("$baseUrl$endPoint$_apiKey$params");

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return MovieUpcomingModel.fromJson(jsonDecode(response.body));
      } else {
        throw failApiMessage;
      }
    } on SocketException {
      throw "No internet connection";
    } catch (e) {
      throw apiErrorMessage;
    }
  }

  Future getDetailMovie(int id) async {
    final endPoint = "/movie/$id";
    final params = "&language=en-US";
    final url = Uri.parse("$baseUrl$endPoint$_apiKey$params");

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return MovieDetailModel.fromJson(jsonDecode(response.body));
      } else {
        throw failApiMessage;
      }
    } on SocketException {
      throw "No internet connection";
    } catch (e) {
      throw apiErrorMessage;
    }
  }

  Future getMovieVideo(int id) async {
    final endPoint = "/movie/$id/videos";
    final params = "&language=en-US";
    final url = Uri.parse("$baseUrl$endPoint$_apiKey$params");

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return MovieVideoModel.fromJson(jsonDecode(response.body));
      } else {
        throw failApiMessage;
      }
    } on SocketException {
      throw "No internet connection";
    } catch (e) {
      throw apiErrorMessage;
    }
  }

  Future getSimiliarMovie(int id) async {
    final endPoint = "/movie/$id/similar";
    final params = "&language=en-US&page=1";
    final url = Uri.parse("$baseUrl$endPoint$_apiKey$params");

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return MovieSimiliarMovieModel.fromJson(jsonDecode(response.body));
      } else {
        throw failApiMessage;
      }
    } on SocketException {
      throw "No internet connection";
    } catch (e) {
      throw apiErrorMessage;
    }
  }

  Future getGenreMovieList() async {
    final endPoint = "/genre/movie/list";
    final url = Uri.parse("$baseUrl$endPoint$_apiKey");

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return GenreMovieListModel.fromJson(jsonDecode(response.body));
      } else {
        throw failApiMessage;
      }
    } on SocketException {
      throw "No internet connection";
    } catch (e) {
      throw apiErrorMessage;
    }
  }
}
