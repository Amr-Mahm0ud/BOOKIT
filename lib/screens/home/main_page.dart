import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/sections/section_body.dart';
import '../../widgets/sections/section_head.dart';
import '../movies/all_movies.dart';
import 'categories.dart';
import '/widgets/home/bottom_nav.dart';
import '/widgets/home/drawer.dart';

import '../../controllers/home/home_controller.dart';
import 'favorites.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(
      () => Scaffold(
        appBar: controller.currentPage != 0
            ? AppBar(
                title: Text(
                    controller.currentPage == 2 ? 'Favorites' : 'Categories'),
              )
            : null,
        extendBody: true,
        key: scaffoldKey,
        body: switchBody(),
        drawer: controller.currentPage.value == 0 ? const MyDrawer() : null,
        bottomNavigationBar: BottomNavBar(
          currentIndex: controller.currentPage.value,
          onTap: controller.onTapped,
        ),
      ),
    );
  }

  SizedBox drawerIcon(controller) {
    return SizedBox(
      width: Get.width * 0.15,
      height: Get.height * 0.085,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 0),
        elevation: 10,
        color: Get.theme.primaryColor,
        shadowColor: Get.theme.primaryColor.withOpacity(0.7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(Get.width),
            bottomRight: Radius.circular(Get.width),
          ),
        ),
        child: IconButton(
          icon: Image.asset(
            'assets/images/menu.png',
            color: Colors.white,
            width: Get.width * 0.1,
          ),
          onPressed: () {
            controller.openDrawer(scaffoldKey);
          },
        ),
      ),
    );
  }

  Expanded searchBar() {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Get.width),
        bottomLeft: Radius.circular(Get.width),
      ),
      borderSide: const BorderSide(
        style: BorderStyle.none,
      ),
    );
    return Expanded(
      child: Card(
        margin: EdgeInsets.only(left: Get.width * 0.1),
        elevation: 10,
        shadowColor: Get.theme.primaryColor.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Get.width),
            bottomLeft: Radius.circular(Get.width),
          ),
        ),
        child: TextFormField(
          // controller: searchController,
          autocorrect: true,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: Get.height * 0.029),
            prefixIcon:
                Icon(Icons.search_rounded, color: Get.theme.primaryColor),
            hintText: 'Search for movies..',
            border: InputBorder.none,
            enabledBorder: border,
            disabledBorder: border,
            errorBorder: border,
            focusedErrorBorder: border,
            focusedBorder: border,
            filled: true,
            fillColor: Get.theme.cardTheme.color,
          ),
        ),
      ),
    );
  }

  buildHomeBody(context, controller) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              //drawer & search bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [drawerIcon(controller), searchBar()],
              ),
              SizedBox(height: Get.height * 0.015),
              const SectionHead(title: 'Trending'),
              const SectionBody('Trending'),
              const SectionHead(title: 'Top Rated'),
              const SectionBody('Top Rated'),
              const SectionHead(title: 'All Movies'),
              const AllMovies(asWidget: true),
            ],
          ),
        ),
      ),
    );
  }

  switchBody() {
    switch (Get.find<HomeController>().currentPage.value) {
      case 0:
        return buildHomeBody(Get.context, Get.find<HomeController>());
      case 1:
        return Categories();
      case 2:
        return const Favorites();
      default:
        return buildHomeBody(Get.context, Get.find<HomeController>());
    }
  }
}
