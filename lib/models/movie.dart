import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/end_points.dart';

class MovieList {
  int? page;
  int? totalMovies;
  int? totalPages;
  List<Movie>? movies;

  MovieList({page, totalMovies, totalPages, movies});

  static fromJson(Map<String, dynamic> json) {
    try {
      MovieList movieList = MovieList();
      movieList.page = json['page'];
      movieList.totalMovies = json['total_results'];
      movieList.totalPages = json['total_pages'];
      if (json['results'] != null) {
        movieList.movies = [];
        json['results'].forEach((item) {
          movieList.movies!.add(Movie.fromJson(item));
        });
      }
      return movieList;
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Get.theme.errorColor.withOpacity(0.5),
        colorText: Colors.white,
      );
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['page'] = page;
  //   data['total_results'] = totalMovies;
  //   data['total_pages'] = totalPages;
  //   if (movies != null) {
  //     data['results'] = movies!.map((item) => item.toJson()).toList();
  //   }
  //   return data;
  // }
}

class Movie {
  int? voteCount;
  int? id;
  bool? video;
  String? voteAverage;
  String? title;
  double? popularity;
  String? posterPath;
  String? originalLanguage;
  String? originalTitle;
  List<int>? genreIds;
  String? backdropPath;
  bool? adult;
  String? overview;
  String? releaseDate;
  String? tagLine;
  List<String>? genres;
  List<String>? languages;
  List<String>? productionCompanies;
  List<String>? productionCountries;

  Movie({
    voteCount,
    id,
    video,
    voteAverage,
    title,
    popularity,
    posterPath,
    originalLanguage,
    originalTitle,
    genreIds,
    backdropPath,
    adult,
    overview,
    releaseDate,
    tagLine,
    genres,
    languages,
    productionCompanies,
    productionCountries,
  });

  Movie.fromJson(Map<String, dynamic> json) {
    voteCount = json['vote_count'] ?? 0;
    id = json['id'];
    video = json['video'] ?? false;
    voteAverage = json['vote_average'].toString();
    title = json['title'] ?? '';
    popularity = json['popularity'] == null ? 0.0 : json['popularity'] + 0.0;
    posterPath = imageURL + json['poster_path'].toString();
    originalLanguage = json['original_language'] ?? '';
    originalTitle = json['original_title'] ?? '';
    if (json['genre_ids'] != null) genreIds = json['genre_ids'].cast<int>();
    backdropPath = imageURL + json['backdrop_path'].toString();
    adult = json['adult'] ?? false;
    overview = json['overview'] ?? '';
    releaseDate = json['release_date'] ?? '';
    tagLine = json['tagline'] ?? '';
    if (json['genres'] != null) {
      genres = [];
      json['genres'].forEach((item) {
        genres!.add(item['name']);
      });
    }
    if (json['spoken_languages'] != null) {
      languages = [];
      json['spoken_languages'].forEach((item) {
        languages!.add(item['name']);
      });
    }
    if (json['production_companies'] != null) {
      productionCompanies = [];
      json['production_companies'].forEach((item) {
        productionCompanies!.add(item['name']);
      });
    }
    if (json['production_countries'] != null) {
      productionCountries = [];
      json['production_countries'].forEach((item) {
        productionCountries!.add(item['name']);
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['vote_count'] = voteCount;
  //   data['id'] = id;
  //   data['video'] = video;
  //   data['vote_average'] = voteAverage;
  //   data['title'] = title;
  //   data['popularity'] = popularity;
  //   data['poster_path'] = posterPath;
  //   data['original_language'] = originalLanguage;
  //   data['original_title'] = originalTitle;
  //   data['genre_ids'] = genreIds;
  //   data['backdrop_path'] = backdropPath;
  //   data['adult'] = adult;
  //   data['overview'] = overview;
  //   data['release_date'] = releaseDate;
  //   return data;
  // }
}

class Genre {
  int? id;
  String? name;

  Genre({id, name});

  static fromJson(Map<String, dynamic> json) {
    List<Genre> genres = [];
    try {
      for (var item in json['genres']) {
        var genre = Genre();
        genre.name = item['name'];
        genre.id = item['id'];
        genres.add(genre);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Get.theme.errorColor.withOpacity(0.5),
        colorText: Colors.white,
      );
    }
    return genres;
  }
}
