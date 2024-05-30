import 'package:get/get.dart';

import '../controllers/all_movies_controller.dart';

class FetchMoreBinding extends Bindings {
  final String listName;
  FetchMoreBinding(this.listName);

  @override
  void dependencies() {
    Get.lazyPut(() => InfiniteScrollController(listName));
  }
}
