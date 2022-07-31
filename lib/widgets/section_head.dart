import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/movies/all_movies.dart';

class SectionHead extends StatelessWidget {
  final String title;
  const SectionHead({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: () {
        Get.to(() => AllMovies(asWidget: false, title: title));
      },
    );
  }
}
