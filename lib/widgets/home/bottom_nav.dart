import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/home_controller.dart';

class BottomNavBar extends StatelessWidget {
  final HomeController controller;
  const BottomNavBar({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 15,
          sigmaY: 15,
        ),
        child: BottomNavigationBar(
          elevation: 0,
          iconSize: 25,
          selectedIconTheme: Theme.of(context)
              .iconTheme
              .copyWith(color: Theme.of(context).primaryColor, size: 35),
          enableFeedback: true,
          unselectedItemColor:
              Theme.of(context).iconTheme.color!.withOpacity(0.5),
          backgroundColor: Theme.of(context).cardColor.withOpacity(0.5),
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.currentPage.value,
          onTap: (val) {
            controller.onTapped(val);
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(controller.currentPage.value == 0
                  ? Icons.home_rounded
                  : Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(controller.currentPage.value == 1
                  ? Icons.category_rounded
                  : Icons.category_outlined),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(controller.currentPage.value == 2
                  ? Icons.favorite_rounded
                  : Icons.favorite_outline_rounded),
              label: 'Favorites',
            ),
          ],
        ),
      ),
    );
  }
}
