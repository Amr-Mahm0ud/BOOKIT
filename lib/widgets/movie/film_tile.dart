import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../bindings/movie_binding.dart';
import '../../controllers/db/movie_controller.dart';
import '../../models/movie.dart';
import '../../screens/movies/movie_details.dart';

class FilmTile extends StatelessWidget {
  final Movie movie;

  const FilmTile({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final subtitleStyle = Theme.of(context)
        .textTheme
        .titleSmall!
        .copyWith(color: Theme.of(context).textTheme.headlineMedium!.color);
    return GestureDetector(
      onTap: () {
        MovieController.id = movie.id.toString();
        Get.to(
          () => const MovieDetails(),
          binding: MovieBinding(),
        );
      },
      child: SizedBox(
        height: Get.height * 0.15,
        child: Material(
          borderRadius: BorderRadius.circular(15),
          shadowColor: Get.theme.primaryColor.withOpacity(0.25),
          elevation: 10,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width * 0.33,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  image: DecorationImage(
                    image: NetworkImage(
                      movie.posterPath.toString(),
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                      Text('${movie.voteCount}, Votes'),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(double.parse(movie.voteAverage.toString())
                              .toStringAsFixed(2)),
                          const Icon(Icons.star, color: Colors.amber),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
