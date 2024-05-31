import 'package:get/get.dart';

import '../controllers/infinite_scroll_controller.dart';

class FetchMoreBinding extends Bindings {
  final String listName;
  final int? movieId;
  final int? genreId;
  FetchMoreBinding({
    this.movieId,
    this.genreId,
    required this.listName,
  });

  @override
  void dependencies() {
    Get.lazyPut(
      () => InfiniteScrollController(
        listName: listName,
        movieId: movieId,
        genreId: genreId,
      ),
    );
  }
}
