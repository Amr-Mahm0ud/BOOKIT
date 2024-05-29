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
    getAllData();
  }

  RxBool isLoading = false.obs;

  RxList<MovieList> trendingList = <MovieList>[].obs;
  RxList<MovieList> topRatedList = <MovieList>[].obs;
  RxList<MovieList> nowPlayingList = <MovieList>[].obs;
  RxList<MovieList> popularList = <MovieList>[].obs;
  RxList<MovieList> upcomingList = <MovieList>[].obs;
  RxList<MovieList> allMoviesList = <MovieList>[].obs;
  RxList<MovieList> recommendations = <MovieList>[].obs;
  RxList<MovieList> searchResults = <MovieList>[].obs;

  RxList<Genre> allGenres = <Genre>[].obs;
  RxList<MovieList> moviesInGenre = <MovieList>[].obs;

  RxList<Movie> favorites = <Movie>[].obs;

  getAllData() async {
    isLoading(true);
    await fetchAllMovies();
    await fetchTopRated();
    await fetchTrending();
    await fetchNowPlaying();
    await fetchPopular();
    await fetchUpcoming();
    await getFavorites();
    if (favorites.isNotEmpty) {
      await fetchRecommendations(favorites.last.id);
    } else {
      await fetchRecommendations(topRatedList.first.movies!.first.id);
    }
    isLoading(false);
  }

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
          backgroundColor: Get.theme.colorScheme.error.withOpacity(0.5),
          colorText: Colors.white,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        backgroundColor: Get.theme.colorScheme.error.withOpacity(0.5),
        colorText: Colors.white,
      );
    }
    update();
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
          backgroundColor: Get.theme.colorScheme.error.withOpacity(0.5),
          colorText: Colors.white,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        error.toString(),
        backgroundColor: Get.theme.colorScheme.error.withOpacity(0.5),
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
          backgroundColor: Get.theme.colorScheme.error.withOpacity(0.5),
          colorText: Colors.white,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        error.toString(),
        backgroundColor: Get.theme.colorScheme.error.withOpacity(0.5),
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
          backgroundColor: Get.theme.colorScheme.error.withOpacity(0.5),
          colorText: Colors.white,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        error.toString(),
        backgroundColor: Get.theme.colorScheme.error.withOpacity(0.5),
        colorText: Colors.white,
      );
    }
    update();
  }

  fetchNowPlaying() async {
    try {
      var res = await http.get(Uri.parse(EndPoints.nowPlaying));
      if (res.statusCode == 200) {
        var body = json.decode(res.body);
        nowPlayingList.add(MovieList.fromJson(body));
      } else {
        Get.snackbar(
          'Error',
          'Something went wrong',
          backgroundColor: Get.theme.colorScheme.error.withOpacity(0.5),
          colorText: Colors.white,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        error.toString(),
        backgroundColor: Get.theme.colorScheme.error.withOpacity(0.5),
        colorText: Colors.white,
      );
    }
    update();
  }

  fetchPopular() async {
    try {
      var res = await http.get(Uri.parse(EndPoints.popular));
      if (res.statusCode == 200) {
        var body = json.decode(res.body);
        popularList.add(MovieList.fromJson(body));
      } else {
        Get.snackbar(
          'Error',
          'Something went wrong',
          backgroundColor: Get.theme.colorScheme.error.withOpacity(0.5),
          colorText: Colors.white,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        error.toString(),
        backgroundColor: Get.theme.colorScheme.error.withOpacity(0.5),
        colorText: Colors.white,
      );
    }
    update();
  }

  fetchUpcoming() async {
    try {
      var res = await http.get(Uri.parse(EndPoints.upcoming));
      if (res.statusCode == 200) {
        var body = json.decode(res.body);
        upcomingList.add(MovieList.fromJson(body));
      } else {
        Get.snackbar(
          'Error',
          'Something went wrong',
          backgroundColor: Get.theme.colorScheme.error.withOpacity(0.5),
          colorText: Colors.white,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        error.toString(),
        backgroundColor: Get.theme.colorScheme.error.withOpacity(0.5),
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
          backgroundColor: Get.theme.colorScheme.error.withOpacity(0.5),
          colorText: Colors.white,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        error.toString(),
        backgroundColor: Get.theme.colorScheme.error.withOpacity(0.5),
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
        backgroundColor: Get.theme.colorScheme.error.withOpacity(0.5),
        colorText: Colors.white,
      );
    }
    update();
  }

  fetchRecommendations(id) async {
    try {
      var res = await http
          .get(Uri.parse('$baseURL/movie/$id/recommendations?api_key=$apiKey'));
      if (res.statusCode == 200) {
        var body = json.decode(res.body);
        recommendations.add(MovieList.fromJson(body));
      } else {
        Get.snackbar(
          'Error',
          'Something went wrong',
          backgroundColor: Get.theme.colorScheme.error.withOpacity(0.5),
          colorText: Colors.white,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        error.toString(),
        backgroundColor: Get.theme.colorScheme.error.withOpacity(0.5),
        colorText: Colors.white,
      );
    }
    update();
  }

  void addMovieToFavorites(movieID, movie) async {
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
        backgroundColor: Get.theme.colorScheme.error.withOpacity(0.5),
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
        backgroundColor: Get.theme.colorScheme.error.withOpacity(0.5),
        colorText: Colors.white,
      );
    });
  }

  searchByMovieName(String movieName) async {
    isLoading(true);
    searchResults.clear();
    try {
      var res =
          await http.get(Uri.parse('${EndPoints.searchByName}$movieName'));
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        print(body);
        searchResults.add(MovieList.fromJson(body));
      } else {
        Get.snackbar(
          'Error',
          'Something went wrong',
          backgroundColor: Get.theme.colorScheme.error.withOpacity(0.5),
          colorText: Colors.white,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        error.toString(),
        backgroundColor: Get.theme.colorScheme.error.withOpacity(0.5),
        colorText: Colors.white,
      );
    }
    isLoading(false);
    update();
  }
}
