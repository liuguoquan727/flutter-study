import 'dart:convert';

import 'package:meta/meta.dart';

class Movie {
  String title = "";
  String average = ""; //这里解析 double 是报错的，不应该啊？！
  int collectCount = 0;
  String smallImage = "";
  String director = "";
  String cast = "";
  String movieId = "";

  //构造函数
  Movie({
    @required this.title,
    @required this.average,
    @required this.collectCount,
    @required this.smallImage,
    @required this.director,
    @required this.cast,
    @required this.movieId,
  });

  static List<Movie> allFromResponse(String json) {
    List<Movie> movies = [];
    final subjects = JSON.decode(json)['subjects'];
    for (var value in subjects) {
      movies.add(Movie.fromMap(value));
    }
    return movies;
  }

  static List<Movie> allFrom() {
    List<Movie> movies = [];
    for (int i = 0; i < 10; i++) {
      Movie movie = new Movie();
      movie.movieId = "12345";
      movie.title = "222";
      movie.average = "0.5";
      movie.cast = "ww";
      movie.director = "eee";
      movie.collectCount = 23;
      movies.add(movie);
    }
    return movies;
  }

  static Movie fromMap(Map map) {
    List directors = map['directors'];
    List casts = map['casts'];
    var d = '';
    for (int i = 0; i < directors.length; i++) {
      if (i == 0) {
        d = d + directors[i]['name'];
      } else {
        d = d + '/' + directors[i]['name'];
      }
    }
    var c = '';
    for (int i = 0; i < casts.length; i++) {
      if (i == 0) {
        c = c + casts[i]['name'];
      } else {
        c = c + '/' + casts[i]['name'];
      }
    }
    return new Movie(
      title: map['title'],
      average: map['rating']['average'].toString(),
      collectCount: map['collect_count'],
      smallImage: map['images']['small'],
      director: d,
      cast: c,
      movieId: map['id'],
    );
  }
}
