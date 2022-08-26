import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants/end_points.dart';

import '../../models/movie.dart';
import 'package:http/http.dart' as http;

import '../auth/auth_controller.dart';

class TMDBController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchAllMovies();
    fetchTopRated();
    fetchTrending();
  }

  RxList<MovieList> trendingList = <MovieList>[].obs;
  RxList<MovieList> topRatedList = <MovieList>[].obs;
  RxList<MovieList> allMoviesList = <MovieList>[].obs;

  RxList<Genre> allGenres = <Genre>[].obs;
  RxList<MovieList> moviesInGenre = <MovieList>[].obs;

  RxList<Movie> favorites = <Movie>[].obs;

  Rx<Movie> movie = Movie().obs;

  getMoviesInGenre(genre) async {
    moviesInGenre.clear();
    try {
      final http.Response res = await http
          .get(Uri.parse('${EndPoints.allMovies}&with_genres=$genre'));
      if (res.statusCode == 200) {
        var body = json.decode(res.body);
        moviesInGenre.add(MovieList.fromJson(body));
      } else {
        Get.snackbar(
          'Error',
          'Something went wrong',
          backgroundColor: Get.theme.errorColor.withOpacity(0.5),
          colorText: Colors.white,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        backgroundColor: Get.theme.errorColor.withOpacity(0.5),
        colorText: Colors.white,
      );
    }
    update();
  }

  fetchMovie(String id) async {
    try {
      final http.Response res =
          await http.get(Uri.parse('$baseURL/movie/$id?api_key=$apiKey'));
      if (res.statusCode == 200) {
        var body = json.decode(res.body);
        movie.value = Movie.fromJson(body);
      } else {
        Get.snackbar(
          'Error',
          'Something went wrong',
          backgroundColor: Get.theme.errorColor.withOpacity(0.5),
          colorText: Colors.white,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        error.toString(),
        backgroundColor: Get.theme.errorColor.withOpacity(0.5),
        colorText: Colors.white,
      );
    }
  }

  fetchAllMovies() async {
    try {
      var res = await http.get(Uri.parse(EndPoints.allMovies));
      if (res.statusCode == 200) {
        var body = json.decode(res.body);
        allMoviesList.add(MovieList.fromJson(body));
      } else {
        Get.snackbar(
          'Error',
          'Something went wrong',
          backgroundColor: Get.theme.errorColor.withOpacity(0.5),
          colorText: Colors.white,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        error.toString(),
        backgroundColor: Get.theme.errorColor.withOpacity(0.5),
        colorText: Colors.white,
      );
    }
    update();
  }

  fetchTrending() async {
    try {
      var res = await http.get(Uri.parse(EndPoints.trending));
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        trendingList.add(MovieList.fromJson(body));
      } else {
        Get.snackbar(
          'Error',
          'Something went wrong',
          backgroundColor: Get.theme.errorColor.withOpacity(0.5),
          colorText: Colors.white,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        error.toString(),
        backgroundColor: Get.theme.errorColor.withOpacity(0.5),
        colorText: Colors.white,
      );
    }
    update();
  }

  fetchTopRated() async {
    try {
      var res = await http.get(Uri.parse(EndPoints.topRated));
      if (res.statusCode == 200) {
        var body = json.decode(res.body);
        topRatedList.add(MovieList.fromJson(body));
      } else {
        Get.snackbar(
          'Error',
          'Something went wrong',
          backgroundColor: Get.theme.errorColor.withOpacity(0.5),
          colorText: Colors.white,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        error.toString(),
        backgroundColor: Get.theme.errorColor.withOpacity(0.5),
        colorText: Colors.white,
      );
    }
    update();
  }

  getAllGenres() async {
    try {
      var res = await http.get(Uri.parse(EndPoints.allGenres));
      if (res.statusCode == 200) {
        var body = json.decode(res.body);
        allGenres = RxList<Genre>(Genre.fromJson(body));
      } else {
        Get.snackbar(
          'Error',
          'Something went wrong',
          backgroundColor: Get.theme.errorColor.withOpacity(0.5),
          colorText: Colors.white,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        error.toString(),
        backgroundColor: Get.theme.errorColor.withOpacity(0.5),
        colorText: Colors.white,
      );
    }
    update();
  }

  getFavorites() async {
    favorites.clear();
    try {
      String userID = '';
      if (AuthController.firebaseUser.value != null) {
        userID = AuthController.firebaseUser.value!.uid;
      } else {
        userID = AuthController.googleSignInAccount.value!.id;
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('favorites')
          .get()
          .then(
        (value) {
          if (value.docs.isNotEmpty) {
            for (var element in value.docs) {
              favorites.add(Movie.fromJson(element.data()));
            }
          }
        },
      );
    } catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        backgroundColor: Get.theme.errorColor.withOpacity(0.5),
        colorText: Colors.white,
      );
    }
    update();
  }

  void addMovieToFavorites(movieID) async {
    String userID = '';
    if (AuthController.firebaseUser.value != null) {
      userID = AuthController.firebaseUser.value!.uid;
    } else {
      userID = AuthController.googleSignInAccount.value!.id;
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('favorites')
        .doc(movieID.toString())
        .set({
      'id': movieID,
      'poster_path': movie.value.backdropPath,
      'title': movie.value.title,
      'release_date': movie.value.releaseDate,
      'original_language': movie.value.originalLanguage,
      'vote_average': movie.value.voteAverage
    }).then(
      (value) async {
        Get.snackbar(
          'Done!',
          'Movie added successfully',
          backgroundColor: Get.theme.primaryColor.withOpacity(0.5),
          colorText: Colors.white,
        );
        await getFavorites();
      },
    ).catchError((error) {
      Get.snackbar(
        'Error!',
        error,
        backgroundColor: Get.theme.errorColor.withOpacity(0.5),
        colorText: Colors.white,
      );
    });
  }

  void removeFromFavorites(movieID) async {
    String userID = '';
    if (AuthController.firebaseUser.value != null) {
      userID = AuthController.firebaseUser.value!.uid;
    } else {
      userID = AuthController.googleSignInAccount.value!.id;
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('favorites')
        .doc(movieID.toString())
        .delete()
        .then(
      (value) async {
        Get.snackbar(
          'Done!',
          'Movie removed successfully',
          backgroundColor: Get.theme.primaryColor.withOpacity(0.5),
          colorText: Colors.white,
        );
        await getFavorites();
      },
    ).catchError((error) {
      Get.snackbar(
        'Error!',
        error,
        backgroundColor: Get.theme.errorColor.withOpacity(0.5),
        colorText: Colors.white,
      );
    });
  }

  static MovieList switchSection(sectionName, controller) {
    switch (sectionName) {
      case 'Trending':
        return controller.trendingList.first;
      case 'Top Rated':
        return controller.topRatedList.first;
      case 'All Movies':
        return controller.allMoviesList.first;
      default:
        return controller.allMoviesList.first;
    }
  }
}
