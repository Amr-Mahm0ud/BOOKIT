
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app/controllers/db/movie_controller.dart';
import 'package:movie_app/controllers/db/tmdb_controller.dart';
import 'package:movie_app/screens/booking/booking.dart';
import 'package:movie_app/widgets/sections/section_head.dart';
import 'package:movie_app/widgets/welcome/button.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../widgets/movie/film_card.dart';
import 'all_movies.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MovieController controller = Get.find<MovieController>();
    final TMDBController tmdbcontroller = Get.find<TMDBController>();
    return
        // YoutubePlayerBuilder(
        //   builder: (p0, p1) =>
        Scaffold(
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(
              child: Lottie.asset(
                'assets/lotties/loading.json',
                width: Get.width * 0.3,
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1.2,
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
                                tmdbcontroller.favorites.any(
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
                                tmdbcontroller.addMovieToFavorites(
                                    controller.movie.value.id,
                                    controller.movie);
                              } else if (value == 1) {
                                tmdbcontroller.removeFromFavorites(
                                    controller.movie.value.id);
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
                      if (!controller.movie.value.backdropPath!
                          .contains('null'))
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: Get.width * 0.025),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: controller.videos.isEmpty
                                  ? DecorationImage(
                                      image: NetworkImage(
                                        controller.movie.value.backdropPath!,
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: controller.videos.isNotEmpty
                                ? YoutubePlayer(
                                    controller: controller.videoController)
                                : null,
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
                                    await tmdbcontroller
                                        .getMoviesInGenre(genre.id)
                                        .then((_) => Get.to(
                                              () => AllMovies(
                                                asWidget: false,
                                                title: genre.name,
                                                genreId: genre.id,
                                                list: tmdbcontroller
                                                    .moviesInGenre
                                                    .first
                                                    .movies!,
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
                      if (controller.similarMovies.first.movies!.isNotEmpty ||
                          controller.recommendations.first.movies!.isNotEmpty)
                        Divider(
                          color: Get.theme.iconTheme.color!.withOpacity(0.5),
                          thickness: 1,
                        ),
                      if (controller
                          .similarMovies.first.movies!.isNotEmpty) ...[
                        SectionHead(
                          title: 'Similar Movies',
                          details: true,
                          list: controller.similarMovies.first.movies!,
                          onTap: () {
                            Get.off(
                              () => AllMovies(
                                asWidget: false,
                                title: 'Similar Movies',
                                list: controller.similarMovies.first.movies!,
                              ),
                            );
                          },
                        ),
                        sectionBodyFromDetails(
                          controller.similarMovies.first.movies!,
                          controller,
                          padding: false,
                        ),
                      ],
                      if (controller
                          .recommendations.first.movies!.isNotEmpty) ...[
                        SectionHead(
                          title: 'Recommendations',
                          details: true,
                          list: controller.recommendations.first.movies!,
                          onTap: () {
                            Get.off(
                              () => AllMovies(
                                asWidget: false,
                                title: 'Recommendations',
                                list: controller.recommendations.first.movies!,
                              ),
                            );
                          },
                        ),
                        sectionBodyFromDetails(
                          controller.recommendations.first.movies!,
                          controller,
                          padding: false,
                        ),
                      ],
                      //Button
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Get.height * 0.015),
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
    ); // player: YoutubePlayer(
    //   controller: controller.videoController,
    //   showVideoProgressIndicator: true,
    //   progressIndicatorColor: Colors.blueAccent,
    //   topActions: <Widget>[
    //     const SizedBox(width: 8.0),
    //     Expanded(
    //       child: Text(
    //         controller.videoController.metadata.title,
    //         style: const TextStyle(
    //           color: Colors.white,
    //           fontSize: 18.0,
    //         ),
    //         overflow: TextOverflow.ellipsis,
    //         maxLines: 1,
    //       ),
    //     ),
    //     IconButton(
    //       icon: const Icon(
    //         Icons.settings,
    //         color: Colors.white,
    //         size: 25.0,
    //       ),
    //       onPressed: () {
    //         log('Settings Tapped!');
    //       },
    //     ),
    //   ],
    // ),
    // );
  }

  sectionBodyFromDetails(list, controller, {padding}) {
    return SizedBox(
      height: Get.height * 0.325,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: padding
                  ? EdgeInsets.only(
                      left: index == 0 ? 15 : 0,
                      right: index == list.length - 1 ? 15 : 0)
                  : EdgeInsets.zero,
              child: FilmCard(
                movie: list[index],
                onTap: () {
                  MovieController.id = list[index].id.toString();
                  controller.getAllData();
                },
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 20);
          },
          itemCount: list.length),
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
