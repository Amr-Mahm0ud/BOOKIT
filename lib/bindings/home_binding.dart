import 'package:get/get.dart';
import 'package:movie_app/controllers/home/home_controller.dart';

import '../controllers/db/tmdb_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(TMDBController());
  }
}
