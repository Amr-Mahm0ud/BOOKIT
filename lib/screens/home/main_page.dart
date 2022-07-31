import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/section_body.dart';
import '../../widgets/section_head.dart';
import '../movies/all_movies.dart';
import 'categories.dart';
import '/widgets/home/bottom_nav.dart';
import '/widgets/home/drawer.dart';

import '/controllers/home_controller.dart';
import 'favorites.dart';

class MainPage extends GetView<HomeController> {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Get.width),
        bottomLeft: Radius.circular(Get.width),
      ),
      borderSide: const BorderSide(
        style: BorderStyle.none,
      ),
    );

    return Obx(
      () => Scaffold(
        extendBody: true,
        key: controller.scaffoldKey,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SafeArea(
              child: Column(
                children: [
                  //drawer & search bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width * 0.15,
                        height: Get.height * 0.085,
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 0),
                          elevation: 10,
                          color: Theme.of(context).primaryColor,
                          shadowColor:
                              Theme.of(context).primaryColor.withOpacity(0.5),
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
                              controller.openDrawer();
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          margin: EdgeInsets.only(left: Get.width * 0.1),
                          elevation: 10,
                          shadowColor:
                              Theme.of(context).primaryColor.withOpacity(0.3),
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
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: Get.height * 0.029),
                              prefixIcon: Icon(Icons.search_rounded,
                                  color: Theme.of(context).primaryColor),
                              hintText: 'Search for movies..',
                              border: InputBorder.none,
                              enabledBorder: border,
                              disabledBorder: border,
                              errorBorder: border,
                              focusedErrorBorder: border,
                              focusedBorder: border,
                              filled: true,
                              fillColor: Theme.of(context).cardColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  controller.currentPage.value == 0
                      ? buildHomeBody()
                      : controller.currentPage.value == 1
                          ? const Categories()
                          : const Favorites()
                ],
              ),
            ),
          ),
        ),
        drawer: const MyDrawer(),
        bottomNavigationBar: BottomNavBar(
          controller: controller,
        ),
      ),
    );
  }
}

buildHomeBody() {
  return Column(
    children: [
      SizedBox(height: Get.height * 0.015),
      const SectionHead(title: 'Trending'),
      const SectionBody('Trending'),
      const SectionHead(title: 'Top Rated'),
      const SectionBody('Top Rated'),
      const SectionHead(title: 'All Movies'),
      const AllMovies(asWidget: true),
    ],
  );
}
