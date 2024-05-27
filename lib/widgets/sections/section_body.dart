import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/db/tmdb_controller.dart';

import '../../models/movie.dart';
import '../movie/film_card.dart';

class SectionBody extends GetView<TMDBController> {
  final List<Movie> list;
  final bool padding;
  const SectionBody(this.list, {super.key, this.padding = true});

  @override
  Widget build(BuildContext context) {
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
              child: FilmCard(movie: list[index]),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 20);
          },
          itemCount: list.length),
    );
  }
}
