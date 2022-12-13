import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/models/movie.dart';

import '../../screens/movies/movie_details.dart';

class FilmCard extends StatelessWidget {
  final Movie movie;

  const FilmCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        Get.to(() => MovieDetails(movieID: movie.id!));
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
                  image: DecorationImage(
                    image: NetworkImage(
                      movie.posterPath.toString(),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
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
