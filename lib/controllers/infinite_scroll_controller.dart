import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/db/tmdb_controller.dart';

class ListNames {
  static const allMovies = 'allMovies';
  static const recommendations = 'reccomndations';
  static const upcoming = 'upcoming';
  static const topTrending = 'topTrending';
  static const popular = 'popular';
  static const topRated = 'topRated';
  static const nowPlaying = 'nowPlaying';
  static const similar = 'similar';
  static const getbyGenre = 'getbyGenre';
}

class InfiniteScrollController extends GetxController {
  final scrollController = ScrollController();
  final TMDBController controller = Get.find<TMDBController>();

  final String listName;
  final int? movieId;
  final int? genreId;
  InfiniteScrollController(
      {required this.listName, this.movieId, this.genreId});

  RxDouble offset = 0.0.obs;

  @override
  void onInit() {
    scrollController.addListener(_onScroll);
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  void _onScroll() {
    offset(scrollController.offset);
    if ((scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - Get.height * 0.5) &&
        !controller.isFetchingMore.value) {
      switch (listName) {
        case 'allMovies':
          controller.fetchAllMovies();
          return;
        case 'reccomndations':
          controller.fetchRecommendations(movieId);
          return;
        case 'upcoming':
          controller.fetchUpcoming();
          return;
        case 'topTrending':
          controller.fetchTrending();
          return;
        case 'popular':
          controller.fetchPopular();
          return;
        case 'topRated':
          controller.fetchTopRated();
          return;
        case 'nowPlaying':
          controller.fetchNowPlaying();
          return;
        case 'similar':
          return;
        case 'getbyGenre':
          controller.getMoreMoviesInGenre(genreId);
          return;
      }
    }
  }
}
