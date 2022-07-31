import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/db/tmdb_controller.dart';

class MovieDetails extends GetView<TMDBController> {
  final int movieID;
  const MovieDetails({required this.movieID, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: controller.fetchMovie(movieID.toString()),
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
                      Align(
                        alignment: const Alignment(-0.9, -0.675),
                        child: CircleAvatar(
                          backgroundColor:
                              Get.theme.primaryColor.withOpacity(0.7),
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
                      //title
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.05),
                          child: Text(
                            controller.movie.value.title.toString(),
                            style: Get.textTheme.headline4!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //tagline, date, votes, rate, backdrop, genres, overview, com, countries & langs, cast, crew
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
                          ),
                        ),
                      ),
                      //genres
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Wrap(
                          children: controller.movie.value.genres!
                              .map(
                                (genre) => Container(
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
                                  child: Text(genre),
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
                      Text(controller.movie.value.overview.toString(),
                          style: Get.textTheme.titleMedium),
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
