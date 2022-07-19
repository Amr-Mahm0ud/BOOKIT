import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomeController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  RxInt currentPage = RxInt(0);

  void selectPage(int index) {
    if (index == 0) {
      currentPage.value = index;
    } else if (index == 1) {
      currentPage.value = index;
    } else if (index == 2) {
      currentPage.value = index;
    }
  }
}
