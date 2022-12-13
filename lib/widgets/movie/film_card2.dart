import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/models/movie.dart';

import '../../screens/movies/movie_details.dart';

class FilmCard2 extends StatelessWidget {
  final Movie movie;
  const FilmCard2({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.9,
      child: GestureDetector(
        onTap: () {
          Get.to(() => MovieDetails(movieID: movie.id!));
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
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
                        image: NetworkImage(movie.backdropPath!),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${movie.releaseDate!.toString().split('-')[0]}, ${movie.originalLanguage}',
                  ),
                  const Spacer(),
                  Text(double.parse(movie.voteAverage.toString())
                      .toStringAsFixed(2)),
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
