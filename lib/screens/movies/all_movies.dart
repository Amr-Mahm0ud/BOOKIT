import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/db/tmdb_controller.dart';

import '../../widgets/movie/film_tile.dart';

class AllMovies extends GetView<TMDBController> {
  final bool asWidget;
  final String? title;
  final int? genreId;
  const AllMovies({Key? key, required this.asWidget, this.title, this.genreId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return asWidget
        ? ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return FilmTile(
                  movie: controller.allMoviesList.first.movies![index]);
            },
            separatorBuilder: (_, index) {
              return const Divider();
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
                ? FutureBuilder(
                    future: controller.getMoviesInGenre(genreId),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LinearProgressIndicator();
                      } else if (controller.moviesInGenre.isEmpty) {
                        return const LinearProgressIndicator();
                      }
                      return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return FilmTile(
                                movie: controller
                                    .moviesInGenre.first.movies![index]);
                          },
                          separatorBuilder: (_, index) {
                            return const Divider();
                          },
                          itemCount:
                              controller.moviesInGenre.first.movies!.length);
                    })
                : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return FilmTile(
                          movie: TMDBController.switchSection(title, controller)
                              .movies![index]);
                    },
                    separatorBuilder: (_, index) {
                      return const Divider();
                    },
                    itemCount: TMDBController.switchSection(title, controller)
                        .movies!
                        .length,
                  ),
          );
  }
}
