import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/db/tmdb_controller.dart';
import 'package:movie_app/models/movie.dart';

import '../../widgets/movie/film_tile.dart';

class AllMovies extends GetView<TMDBController> {
  final bool asWidget;
  final String? title;
  final int? genreId;
  final List<Movie> list;
  const AllMovies({
    super.key,
    required this.asWidget,
    required this.list,
    this.title,
    this.genreId,
  });

  @override
  Widget build(BuildContext context) {
    return asWidget
        ? ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: Get.size.width * 0.05),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return FilmTile(movie: list[index]);
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
                      return FilmTile(movie: list[index]);
                    },
                    separatorBuilder: (_, index) {
                      return const Divider();
                    },
                    itemCount: list.length,
                  ),
          );
  }
}
