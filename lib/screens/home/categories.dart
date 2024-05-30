import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app/bindings/fetch_more_binding.dart';
import 'package:movie_app/controllers/all_movies_controller.dart';

import 'package:movie_app/controllers/db/tmdb_controller.dart';

import '../movies/all_movies.dart';

class Categories extends GetView<TMDBController> {
  Categories({super.key});
  final List<String> genreImages = [
    'assets/images/genres/action.png',
    'assets/images/genres/adventure.png',
    'assets/images/genres/animation.png',
    'assets/images/genres/comedy.png',
    'assets/images/genres/crime.png',
    'assets/images/genres/documentary.png',
    'assets/images/genres/drama.png',
    'assets/images/genres/family.png',
    'assets/images/genres/fantasy.png',
    'assets/images/genres/history.png',
    'assets/images/genres/horror.png',
    'assets/images/genres/music.png',
    'assets/images/genres/mystery.png',
    'assets/images/genres/romance.png',
    'assets/images/genres/science_fiction.png',
    'assets/images/genres/tv_movie.png',
    'assets/images/genres/thriller.png',
    'assets/images/genres/war.png',
    'assets/images/genres/western.png',
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.getAllGenres(),
        builder: (context, _) {
          if (controller.allGenres.isEmpty) {
            return Center(
              child: Lottie.asset(
                'assets/lotties/loading.json',
                width: Get.width * 0.3,
              ),
            );
          }
          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              left: Get.width * 0.05,
              right: Get.width * 0.05,
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            itemCount: controller.allGenres.length,
            itemBuilder: (context, index) => GestureDetector(
              child: buildGenre(index),
              onTap: () async {
                await controller
                    .getMoviesInGenre(controller.allGenres[index].id)
                    .then(
                      (_) => Get.to(
                        () => AllMovies(
                          asWidget: false,
                          title: controller.allGenres[index].name,
                          genreId: controller.allGenres[index].id,
                          list: controller.moviesInGenre,
                        ),
                        binding: FetchMoreBinding(ListNames.getbyGenre),
                      ),
                    );
              },
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 20,
            ),
          );
        });
  }

  Widget buildGenre(int index) {
    return Material(
      elevation: 10,
      color: Get.theme.cardColor,
      shadowColor: Get.theme.primaryColor.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              genreImages[index],
              color: Get.theme.primaryColor,
              width: Get.size.width * 0.2,
            ),
            const SizedBox(height: 10),
            Text(
              controller.allGenres[index].name.toString(),
              style: Get.textTheme.titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
