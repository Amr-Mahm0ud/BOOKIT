import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'categories.dart';
import '/widgets/home/bottom_nav.dart';
import '/widgets/home/drawer.dart';

import '/controllers/home_controller.dart';
import 'favorites.dart';
import 'home.dart';

class MainPage extends GetView<HomeController> {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      key: controller.scaffoldKey,
      body: Obx(() => controller.currentPage.value == 0
          ? Home()
          : controller.currentPage.value == 1
              ? const Categories()
              : const Favorites()),
      drawer: const MyDrawer(),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
