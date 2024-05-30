import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/bindings/fetch_more_binding.dart';
import 'package:movie_app/models/movie.dart';

import '../../screens/movies/all_movies.dart';

class SectionHead extends StatelessWidget {
  final String title;
  final bool details;
  final List<MovieList> list;
  final String listName;
  final void Function()? onTap;
  const SectionHead(
      {super.key,
      required this.title,
      this.details = false,
      required this.list,
      this.onTap,
      required this.listName});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: details
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 20),
      title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: onTap ??
          () {
            Get.to(
              () => AllMovies(
                asWidget: false,
                title: title,
                list: list,
              ),
              binding: FetchMoreBinding(listName),
            );
          },
    );
  }
}
