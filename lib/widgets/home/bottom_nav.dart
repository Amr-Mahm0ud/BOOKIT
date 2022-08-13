import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;
  const BottomNavBar(
      {Key? key, required this.currentIndex, required this.onTap})
      : super(key: key);

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
          backgroundColor: Get.isDarkMode
              ? Get.theme.cardColor.withOpacity(0.5)
              : Get.theme.primaryColor.withOpacity(0.1),
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (val) {
            onTap(val);
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                  currentIndex == 0 ? Icons.home_rounded : Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(currentIndex == 1
                  ? Icons.category_rounded
                  : Icons.category_outlined),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(currentIndex == 2
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
