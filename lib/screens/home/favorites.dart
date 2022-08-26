import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/screens/movies/movie_details.dart';

import '../../controllers/db/tmdb_controller.dart';
import '../../models/movie.dart';

class Favorites extends GetView<TMDBController> {
  const Favorites({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.getFavorites(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        }
        return Obx(
          () {
            if (controller.favorites.isEmpty &&
                snapshot.connectionState != ConnectionState.waiting) {
              return Center(
                child: Text(
                  'You have no favorites',
                  style: Get.textTheme.headline5!
                      .copyWith(color: Get.textTheme.headline4!.color),
                ),
              );
            }
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: controller.favorites.length,
              itemBuilder: (_, index) {
                Movie movie = controller.favorites[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => MovieDetails(movieID: movie.id!));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: Get.height * 0.02,
                          ),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Material(
                              elevation: 20,
                              borderRadius: BorderRadius.circular(15),
                              shadowColor: Get.isDarkMode
                                  ? Get.theme.primaryColor.withOpacity(0.3)
                                  : Get.theme.shadowColor,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: NetworkImage(movie.posterPath!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          movie.title!,
                          style: Get.textTheme.headline5!,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${movie.releaseDate!.split('-')[0]}, ${movie.originalLanguage}',
                            ),
                            const Spacer(),
                            Text(double.parse(movie.voteAverage.toString())
                                .toStringAsFixed(2)),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            // const SizedBox(width: 20),
                            // IconButton(
                            //   splashRadius: 25,
                            //   padding: EdgeInsets.zero,
                            //   constraints: const BoxConstraints(),
                            //   icon: Icon(
                            //     Icons.delete,
                            //     color: Get.theme.errorColor,
                            //   ),
                            //   onPressed: () {
                            //     controller.removeFromFavorites(movie.id);
                            //     // controller.favorites.remove(movie);
                            //   },
                            // )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
