import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/models/movie.dart';

import '../../bindings/movie_binding.dart';
import '../../controllers/db/movie_controller.dart';
import '../../screens/movies/movie_details.dart';

//The Horizontal Card Used in MainScreen,Favourites & Bookings
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
          padding: EdgeInsets.only(
            left: Get.width * 0.05,
            right: Get.width * 0.05,
            bottom: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Material(
                  elevation: 15,
                  borderRadius: BorderRadius.circular(15),
                  shadowColor: Get.theme.primaryColor.withOpacity(0.3),
                  child: Container(
                    width: Get.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: inFavourite || movie.backdropPath == null
                            ? NetworkImage(movie.posterPath!)
                            : NetworkImage(movie.backdropPath!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black54
                          ],
                        ),
                      ),
                      padding: EdgeInsets.all(Get.size.width * 0.05),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        movie.title.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    ),
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
