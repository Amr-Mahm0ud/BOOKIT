import 'dart:convert';

import 'package:get/get.dart';
import 'package:movie_app/constants/end_points.dart';

import '../../models/movie.dart';
import 'package:http/http.dart' as http;

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

  Rx<Movie> movie = Movie().obs;

  fetchMovie(String id) async {
    try {
      final http.Response res =
          await http.get(Uri.parse('$baseURL/movie/$id?api_key=$apiKey'));
      if (res.statusCode == 200) {
        var body = json.decode(res.body);
        movie.value = Movie.fromJson(body);
      } else {
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (error) {
      Get.snackbar('Error', error.toString());
    }
  }

  fetchAllMovies() async {
    try {
      var res = await http.get(Uri.parse(EndPoints.allMovies));
      if (res.statusCode == 200) {
        var body = json.decode(res.body);
        allMoviesList.add(MovieList.fromJson(body));
      } else {
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (error) {
      Get.snackbar('Error', error.toString());
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
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (error) {
      Get.snackbar('Error', error.toString());
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
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (error) {
      Get.snackbar('Error', error.toString());
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
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (error) {
      Get.snackbar('Error', error.toString());
    }
    update();
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
