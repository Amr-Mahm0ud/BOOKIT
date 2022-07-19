import 'package:flutter/material.dart';

import '../widgets/home/film_tile.dart';

class AllMovies extends StatelessWidget {
  final bool asWidget;
  final String? title;
  AllMovies({Key? key, required this.asWidget, this.title}) : super(key: key);
  final List<String> images = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
    'assets/images/5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return asWidget
        ? ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return FilmTile(image: images[index]);
            },
            separatorBuilder: (_, index) {
              return const Divider();
            },
            itemCount: images.length)
        : Scaffold(
            appBar: AppBar(
              title: Text(title!),
            ),
            body: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return FilmTile(image: images[index]);
                },
                separatorBuilder: (_, index) {
                  return const Divider();
                },
                itemCount: images.length),
          );
  }
}
