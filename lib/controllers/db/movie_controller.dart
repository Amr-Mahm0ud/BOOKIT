import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:palette_generator/palette_generator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../constants/end_points.dart';
import '../../models/movie.dart';
import '../../models/videos.dart';

class MovieController extends GetxController {
  @override
  void onInit() {
    getAllData();
    super.onInit();
  }

  Rx<Movie> movie = Movie().obs;
  RxList<MovieList> recommendations = <MovieList>[].obs;
  RxList<MovieList> similarMovies = <MovieList>[].obs;
  RxList<VideoModel> videos = <VideoModel>[].obs;

  YoutubePlayerController videoController =
      YoutubePlayerController(initialVideoId: '');

  Rx<Color> mainColor = Colors.transparent.obs;

  RxBool isLoading = false.obs;

  static String id = '';

  getAllData() async {
    isLoading(true);
    await fetchMovie();
    await fetchRecommendations();
    await fetchSimilarMovies();
    await fetchVideos();
    isLoading(false);
  }

  fetchMovie() async {
    try {
      final http.Response res =
          await http.get(Uri.parse('$baseURL/movie/$id?api_key=$apiKey'));
      if (res.statusCode == 200) {
        var body = json.decode(res.body);
        movie.value = Movie.fromJson(body);
        final paletteGenerator = await PaletteGenerator.fromImageProvider(
          Image.network(movie.value.posterPath!).image,
        );
        mainColor.value = paletteGenerator.dominantColor!.color;
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

  fetchRecommendations() async {
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

  fetchSimilarMovies() async {
    try {
      var res = await http
          .get(Uri.parse('$baseURL/movie/$id/similar?api_key=$apiKey'));
      if (res.statusCode == 200) {
        var body = json.decode(res.body);
        similarMovies.add(MovieList.fromJson(body));
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

  fetchVideos() async {
    try {
      var res = await http
          .get(Uri.parse('$baseURL/movie/$id/videos?api_key=$apiKey'));
      if (res.statusCode == 200) {
        var body = json.decode(res.body);
        if (body['results'].isNotEmpty) {
          videos.add(VideoModel.fromJson(body['results'].first));
        }
        if (videos.isNotEmpty) {
          videoController = YoutubePlayerController(
            initialVideoId: videos.first.key!,
            flags: const YoutubePlayerFlags(autoPlay: false),
          );
        }
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
}
