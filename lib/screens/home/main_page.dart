import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app/controllers/db/tmdb_controller.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/widgets/movie/film_card2.dart';
import '../../widgets/sections/section_body.dart';
import '../../widgets/sections/section_head.dart';
import '../movies/all_movies.dart';
import 'categories.dart';
import '/widgets/home/bottom_nav.dart';
import '/widgets/home/drawer.dart';

import '../../controllers/home/home_controller.dart';
import 'favorites.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.find<HomeController>();
  final tmdbController = Get.find<TMDBController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (tmdbController.isLoading.value) {
          return Scaffold(
            body: Center(
              child: Lottie.asset(
                'assets/lotties/loading.json',
                width: Get.width * 0.3,
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: controller.currentPage != 0
                ? AppBar(
                    title: Text(controller.currentPage == 2
                        ? 'Favorites'
                        : 'Categories'),
                  )
                : null,
            extendBody: true,
            key: scaffoldKey,
            body: SafeArea(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: switchBody(context),
              ),
            ),
            drawer: controller.currentPage.value == 0 ? const MyDrawer() : null,
            bottomNavigationBar: BottomNavBar(
              currentIndex: controller.currentPage.value,
              onTap: controller.onTapped,
            ),
          );
        }
      },
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

  Widget searchBar(context) {
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
          controller: controller.searchController,
          onChanged: (val) {
            controller.changeSearchValue(val);
          },
          autocorrect: true,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: Get.height * 0.029),
            prefixIcon: IconButton(
              color: Get.theme.primaryColor,
              onPressed: controller.searchValue.isEmpty
                  ? null
                  : () {
                      tmdbController.searchByMovieName(
                          controller.searchValue.value.trim());
                    },
              icon: const Icon(Icons.search_rounded),
            ),
            hintText: 'Search for movies...',
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
    );
  }

  buildHomeBody(context, HomeController controller) {
    final TMDBController tmdbcontroller = Get.find<TMDBController>();
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              //drawer & search bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [drawerIcon(controller), searchBar(context)],
              ),
              SizedBox(height: Get.height * 0.015),
              ...(controller.searchController.text.isNotEmpty)
                  ? [
                      tmdbcontroller.searchResults.isEmpty
                          ? Container()
                          : AllMovies(
                              asWidget: true,
                              list: tmdbcontroller.searchResults.first.movies!,
                            ),
                    ]
                  : [
                      //----------------------------------
                      //Recommendations
                      if (tmdbcontroller.recommendations.isNotEmpty) ...[
                        SectionHead(
                          title: 'Recommendations',
                          list: tmdbcontroller.recommendations.first.movies!,
                        ),
                        sectionBody2(
                            tmdbcontroller.recommendations.first.movies!),
                      ],

                      //----------------------------------
                      //UpComing
                      SectionHead(
                        title: 'Upcoming',
                        list: tmdbcontroller.upcomingList.first.movies!,
                      ),
                      sectionBody2(tmdbcontroller.upcomingList.first.movies!),

                      //----------------------------------
                      //Trending
                      SectionHead(
                        title: 'Top Trending',
                        list: tmdbcontroller.trendingList.first.movies!,
                      ),
                      sectionBody2(tmdbcontroller
                          .trendingList.first.movies!.reversed
                          .toList()),

                      //----------------------------------
                      //Popular
                      SectionHead(
                        title: 'Popular',
                        list: tmdbcontroller.popularList.first.movies!,
                      ),
                      SectionBody(tmdbcontroller.popularList.first.movies!),

                      //----------------------------------
                      //Top Rated
                      SectionHead(
                        title: 'Top Rated',
                        list: tmdbcontroller.topRatedList.first.movies!,
                      ),
                      SectionBody(tmdbcontroller.topRatedList.first.movies!),

                      //----------------------------------
                      //Now Playing
                      SectionHead(
                        title: 'Now Playing',
                        list: tmdbcontroller.nowPlayingList.first.movies!,
                      ),
                      sectionBody2(
                        tmdbcontroller.nowPlayingList.first.movies!.reversed
                            .toList(),
                      ),

                      //----------------------------------
                      //All Movies
                      SectionHead(
                        title: 'All Movies',
                        list: tmdbcontroller.allMoviesList.first.movies!,
                      ),
                      AllMovies(
                        asWidget: true,
                        list: tmdbcontroller.allMoviesList.first.movies!,
                      ),
                    ]
            ],
          ),
        ),
      ),
    );
  }

  sectionBody2(List<Movie> list) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: list.map((movie) => FilmCard2(movie: movie)).toList(),
      ),
    );
  }

  switchBody(context) {
    switch (Get.find<HomeController>().currentPage.value) {
      case 0:
        return buildHomeBody(context, Get.find<HomeController>());
      case 1:
        return Categories();
      case 2:
        return const Favorites();
      default:
        return buildHomeBody(context, Get.find<HomeController>());
    }
  }
}
