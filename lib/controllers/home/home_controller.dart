import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  RxString searchValue = ''.obs;

  changeSearchValue(String val) {
    searchController.text = val;
    searchValue(val.trim());
    update();
  }

  openDrawer(scaffoldKey) {
    scaffoldKey.currentState!.openDrawer();
  }

  final RxInt _currentPage = 0.obs;

  set setPage(int index) => _currentPage.value = index;
  get currentPage => _currentPage;
  onTapped(int index) {
    currentPage(index);
    update();
  }
}
