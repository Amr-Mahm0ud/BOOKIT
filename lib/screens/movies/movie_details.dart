import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/db/tmdb_controller.dart';
import 'package:movie_app/screens/booking/booking.dart';
import 'package:movie_app/widgets/welcome/button.dart';

import 'all_movies.dart';

class MovieDetails extends GetView<TMDBController> {
  final int movieID;
  const MovieDetails({required this.movieID, Key? key}) : super(key: key);

  initFun() async {
    await controller.fetchMovie(movieID.toString());
    await controller.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: initFun(),
        builder: (context, snapshot) {
          if (controller.movie.value.id != movieID) {
            return const LinearProgressIndicator();
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.425,
                  child: Stack(
                    children: [
                      //poster
                      ShaderMask(
                        shaderCallback: (Rect rect) => LinearGradient(
                                colors: [
                              Colors.white,
                              Colors.white.withOpacity(0)
                            ],
                                stops: const [
                              0.65,
                              1.0
                            ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)
                            .createShader(rect),
                        child: Image.network(
                          width: Get.width,
                          controller.movie.value.posterPath!,
                          fit: BoxFit.fill,
                        ),
                      ),
                      //back button
                      Positioned(
                        top: Get.height * 0.04,
                        left: Get.width * 0.025,
                        child: CircleAvatar(
                          backgroundColor: Colors.black38,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: Get.height * 0.04,
                        right: Get.width * 0.025,
                        child: CircleAvatar(
                          backgroundColor: Colors.black38,
                          child: PopupMenuButton(
                            icon: const Icon(Icons.more_vert_rounded,
                                color: Colors.white),
                            itemBuilder: (context) {
                              return [
                                controller.favorites.any(
                                  (element) =>
                                      element.id == controller.movie.value.id,
                                )
                                    ? const PopupMenuItem<int>(
                                        value: 1,
                                        child: Text('Remove from favorites'),
                                      )
                                    : const PopupMenuItem<int>(
                                        value: 0,
                                        child: Text('Add to favorites'),
                                      ),
                              ];
                            },
                            onSelected: (value) {
                              if (value == 0) {
                                controller.addMovieToFavorites(movieID);
                              } else if (value == 1) {
                                controller.removeFromFavorites(movieID);
                              }
                            },
                          ),
                        ),
                      ),
                      //title
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.05),
                          child: Text(
                            controller.movie.value.title.toString(),
                            style: Get.textTheme.headline4!
                                .copyWith(color: Get.theme.iconTheme.color),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //tagline, date, votes, rate, backdrop, genres, overview, com, countries & langs
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Get.width * 0.025,
                    horizontal: Get.width * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.movie.value.tagLine!.isNotEmpty
                          ? Text(controller.movie.value.tagLine!)
                          : const SizedBox(),
                      const SizedBox(height: 10),
                      //date, votes, rate
                      Row(
                        children: [
                          Text(controller.movie.value.releaseDate.toString()),
                          const Spacer(),
                          Text('${controller.movie.value.voteCount} Votes'),
                          const SizedBox(width: 15),
                          Text(double.parse(controller.movie.value.voteAverage!)
                              .toStringAsFixed(2)),
                          const Icon(Icons.star, color: Colors.amber),
                          const SizedBox(width: 15),
                        ],
                      ),
                      //backdrop
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: Get.width * 0.025),
                        height: Get.height * 0.24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                                controller.movie.value.backdropPath!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      //genres
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Wrap(
                          children: controller.movie.value.genres!
                              .map(
                                (genre) => GestureDetector(
                                  onTap: () async {
                                    await controller
                                        .getMoviesInGenre(genre.id)
                                        .then((_) => Get.to(
                                              () => AllMovies(
                                                asWidget: false,
                                                title: genre.name,
                                                genreId: genre.id,
                                              ),
                                            ));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 5,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.accents[controller
                                          .movie.value.genres!
                                          .indexOf(genre)],
                                    ),
                                    child: Text(genre.name.toString()),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      Divider(
                        color: Get.theme.iconTheme.color!.withOpacity(0.5),
                        thickness: 1,
                      ),
                      //overview
                      Text('Overview', style: Get.textTheme.headline5),
                      Text(
                        controller.movie.value.overview.toString(),
                        style: Get.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      //com, countries & langs
                      buildInfo(
                        'Companies',
                        controller.movie.value.productionCompanies!,
                      ),
                      buildInfo(
                        'Countries',
                        controller.movie.value.productionCountries!,
                      ),
                      buildInfo(
                        'Languages',
                        controller.movie.value.languages!,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Get.height * 0.025),
                        child: Button(
                          label: 'Book IT',
                          onPressed: () {
                            Get.to(() =>
                                BookingScreen(movie: controller.movie.value));
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Wrap buildInfo(String title, List info) {
    return Wrap(
      children: [
        Text(
          '$title: ',
          style: Get.textTheme.bodyText1!.copyWith(
            color: Get.theme.primaryColor,
          ),
        ),
        ...info.map(
          (item) {
            if (item == info.last) {
              return Text('$item.');
            } else {
              return Text('$item, ');
            }
          },
        ).toList(),
      ],
    );
  }
}
