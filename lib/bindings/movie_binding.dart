import 'package:get/get.dart';
import 'package:movie_app/controllers/db/movie_controller.dart';

class MovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MovieController());
  }
}
