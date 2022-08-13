import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/db/tmdb_controller.dart';

import '../movies/all_movies.dart';

class Categories extends GetView<TMDBController> {
  Categories({Key? key}) : super(key: key);
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
            return const LinearProgressIndicator();
          }
          return GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            itemCount: controller.allGenres.length,
            itemBuilder: (context, index) => GestureDetector(
              child: buildGenre(index),
              onTap: () => Get.to(
                () => AllMovies(
                  asWidget: false,
                  title: controller.allGenres[index].name,
                  genreId: controller.allGenres[index].id,
                ),
              ),
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 20,
            ),
          );
        });
  }

  Card buildGenre(int index) {
    return Card(
      elevation: 10,
      shadowColor: Get.theme.primaryColor.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            genreImages[index],
            color: Get.theme.primaryColor,
          ),
          const SizedBox(height: 10),
          Text(
            controller.allGenres[index].name.toString(),
            style: Get.textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
