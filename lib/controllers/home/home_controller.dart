import 'package:get/get.dart';
import 'package:movie_app/controllers/db/tmdb_controller.dart';

class HomeController extends GetxController {
  openDrawer(scaffoldKey) {
    scaffoldKey.currentState!.openDrawer();
  }

  @override
  void onInit() {
    Get.put(TMDBController());
    super.onInit();
  }

  final RxInt _currentPage = 0.obs;

  set setPage(int index) => _currentPage.value = index;
  get currentPage => _currentPage;
  onTapped(int index) {
    currentPage(index);
    update();
  }
}
