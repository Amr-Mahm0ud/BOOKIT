import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/models/movie.dart';

import '../../bindings/movie_binding.dart';
import '../../controllers/db/movie_controller.dart';
import '../../screens/movies/movie_details.dart';

class FilmCard2 extends StatelessWidget {
  final Movie movie;
  final bool inFavourite;
  const FilmCard2({super.key, required this.movie, this.inFavourite = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.325,
      child: GestureDetector(
        onTap: () {
          MovieController.id = movie.id.toString();
          Get.to(
            () => const MovieDetails(),
            binding: MovieBinding(),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Material(
                  elevation: 20,
                  borderRadius: BorderRadius.circular(15),
                  shadowColor: Get.isDarkMode
                      ? Get.theme.primaryColor.withOpacity(0.3)
                      : Get.theme.shadowColor,
                  child: Container(
                    width: Get.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image:
                            inFavourite || movie.backdropPath!.contains('null')
                                ? NetworkImage(movie.posterPath!)
                                : NetworkImage(movie.backdropPath.toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                movie.title.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Get.textTheme.headline5!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
