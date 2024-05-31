import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/infinite_scroll_controller.dart';
import 'package:movie_app/models/movie.dart';

import '../../controllers/db/tmdb_controller.dart';
import '../../widgets/movie/film_tile.dart';

class AllMovies extends GetView<TMDBController> {
  final bool asWidget;
  final String? title;
  final int? genreId;
  final List<MovieList> list;
  const AllMovies({
    super.key,
    required this.asWidget,
    required this.list,
    this.title,
    this.genreId,
  });

  @override
  Widget build(BuildContext context) {
    InfiniteScrollController? infiniteScrollController =
        asWidget ? null : Get.find<InfiniteScrollController>();
    return asWidget
        ? ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: Get.size.width * 0.05),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return FilmTile(movie: list.first.movies![index]);
            },
            separatorBuilder: (_, index) {
              return const SizedBox(height: 20);
            },
            itemCount: 10)
        : Scaffold(
            appBar: AppBar(
              title: Text(title!),
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () {
                    Get.back();
                  }),
            ),
            body: genreId != null
                ? Obx(
                    () => SingleChildScrollView(
                      controller: infiniteScrollController!.scrollController,
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.size.width * 0.05),
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          ...controller.moviesInGenre.map(
                            (list) => Column(
                              children: list.movies!
                                  .map(
                                    (movie) => Column(
                                      children: [
                                        FilmTile(movie: movie),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          if (controller.isFetchingMore.value)
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: CircularProgressIndicator(),
                            ),
                        ],
                      ),
                    ),
                  )
                : Obx(
                    () => SingleChildScrollView(
                      controller: infiniteScrollController!.scrollController,
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.size.width * 0.05),
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          ...list.map(
                            (list) => Column(
                              children: list.movies!
                                  .map(
                                    (movie) => Column(
                                      children: [
                                        FilmTile(movie: movie),
                                        const SizedBox(height: 20)
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          if (controller.isFetchingMore.value)
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: CircularProgressIndicator(),
                            ),
                        ],
                      ),
                    ),
                  ),
            floatingActionButton: Obx(
              () => infiniteScrollController!.offset > Get.height * 0.5
                  ? FloatingActionButton.small(
                      backgroundColor: Get.theme.primaryColor,
                      onPressed: () {
                        infiniteScrollController.scrollToTop();
                      },
                      child: const Icon(Icons.keyboard_arrow_up_rounded),
                    )
                  : Container(),
            ),
          );
  }
}
