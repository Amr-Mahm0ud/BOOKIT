import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/bindings/movie_binding.dart';
import 'package:movie_app/controllers/db/movie_controller.dart';
import 'package:movie_app/models/movie.dart';

import '../../screens/movies/movie_details.dart';

class FilmCard extends StatelessWidget {
  final Movie movie;
  final void Function()? onTap;

  const FilmCard({Key? key, required this.movie, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap ??
          () {
            MovieController.id = movie.id.toString();
            Get.to(
              () => const MovieDetails(),
              binding: MovieBinding(),
            );
          },
      child: SizedBox(
        width: Get.width * 0.38,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 15,
              shadowColor: Get.isDarkMode
                  ? Get.theme.primaryColor.withOpacity(0.4)
                  : Get.theme.shadowColor,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: Get.width * 0.38,
                height: Get.height * 0.225,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: !(movie.posterPath!.contains('null') &&
                          movie.backdropPath!.contains('null'))
                      ? DecorationImage(
                          image: NetworkImage(
                            movie.posterPath!.contains('null')
                                ? movie.backdropPath!.toString()
                                : movie.posterPath!.toString(),
                          ),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: movie.posterPath!.contains('null') &&
                        movie.backdropPath!.contains('null')
                    ? Center(
                        child: Text(
                          'No Image',
                          style: Get.textTheme.headline4,
                        ),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                movie.title.toString(),
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge!,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
