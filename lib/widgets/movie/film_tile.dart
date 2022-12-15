import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../bindings/movie_binding.dart';
import '../../controllers/db/movie_controller.dart';
import '../../models/movie.dart';
import '../../screens/movies/movie_details.dart';

class FilmTile extends StatelessWidget {
  final Movie movie;

  const FilmTile({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subtitleStyle = Theme.of(context)
        .textTheme
        .subtitle2!
        .copyWith(color: Theme.of(context).textTheme.headline4!.color);
    return GestureDetector(
      onTap: () {
        MovieController.id = movie.id.toString();
        Get.to(
          () => const MovieDetails(),
          binding: MovieBinding(),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: Get.width * 0.33,
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
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title.toString(),
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text('${movie.releaseDate}, ${movie.originalLanguage}',
                      style: subtitleStyle),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(double.parse(movie.voteAverage.toString())
                          .toStringAsFixed(2)),
                      const Icon(Icons.star, color: Colors.amber),
                    ],
                  ),
                  Text(
                    '${movie.overview}',
                    style: subtitleStyle,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
