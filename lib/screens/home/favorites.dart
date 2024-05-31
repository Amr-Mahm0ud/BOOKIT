import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app/widgets/movie/film_card2.dart';

import '../../controllers/db/tmdb_controller.dart';
import '../../models/movie.dart';

class Favorites extends GetView<TMDBController> {
  const Favorites({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.isLoading.value) {
          return Center(
            child: Lottie.asset(
              'assets/lotties/loading.json',
              width: Get.width * 0.3,
            ),
          );
        } else if (controller.favorites.isEmpty &&
            !controller.isLoading.value) {
          return Center(
            child: Text(
              'You have no favorites',
              style: Get.textTheme.headlineSmall!
                  .copyWith(color: Get.textTheme.headlineMedium!.color),
            ),
          );
        }
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: controller.favorites.length,
          itemBuilder: (_, index) {
            Movie movie = controller.favorites[index];
            return FilmCard2(
              movie: movie,
              inFavourite: true,
            );
          },
        );
      },
    );
  }
}
