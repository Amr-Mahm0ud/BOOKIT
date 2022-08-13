import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/db/tmdb_controller.dart';

import '../movie/film_card.dart';

class SectionBody extends GetView<TMDBController> {
  final String sectionName;
  const SectionBody(this.sectionName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.325,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                  left: index == 0 ? 15 : 0,
                  right: index ==
                          TMDBController.switchSection(sectionName, controller)
                                  .movies!
                                  .length -
                              1
                      ? 15
                      : 0),
              child: FilmCard(
                  movie: TMDBController.switchSection(sectionName, controller)
                      .movies![index]),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 20);
          },
          itemCount: TMDBController.switchSection(sectionName, controller)
              .movies!
              .length),
    );
  }
}
