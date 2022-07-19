import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/size.dart';
import '../../controllers/home_controller.dart';
import '../../widgets/home/film_card.dart';
import '../all_movies.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final List<String> images = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
    'assets/images/5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(SizeConfig.screenWidth),
        bottomLeft: Radius.circular(SizeConfig.screenWidth),
      ),
      borderSide: const BorderSide(
        style: BorderStyle.none,
      ),
    );
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              //drawer & search bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.15,
                    height: SizeConfig.screenHeight * 0.085,
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      elevation: 10,
                      color: Theme.of(context).primaryColor,
                      shadowColor:
                          Theme.of(context).primaryColor.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(SizeConfig.screenWidth),
                          bottomRight: Radius.circular(SizeConfig.screenWidth),
                        ),
                      ),
                      child: IconButton(
                        icon: Image.asset(
                          'assets/images/menu.png',
                          color: Colors.white,
                          width: SizeConfig.screenWidth * 0.1,
                        ),
                        onPressed: () {
                          controller.openDrawer();
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      margin:
                          EdgeInsets.only(left: SizeConfig.screenWidth * 0.1),
                      elevation: 10,
                      shadowColor:
                          Theme.of(context).primaryColor.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(SizeConfig.screenWidth),
                          bottomLeft: Radius.circular(SizeConfig.screenWidth),
                        ),
                      ),
                      child: TextFormField(
                        // controller: searchController,
                        autocorrect: true,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: SizeConfig.screenHeight * 0.029),
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
              SizedBox(height: SizeConfig.screenHeight * 0.015),
              buildSectionHead('Newest', context),
              buildSectionBody(),
              buildSectionHead('Top Rated', context),
              buildSectionBody(),
              buildSectionHead('All Movies', context),
              AllMovies(asWidget: true),
            ],
          ),
        ),
      ),
    );
  }

  ListTile buildSectionHead(String title, context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: Theme.of(context).iconTheme.color),
      ),
      trailing: Text(
        'See All',
        style: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(color: Theme.of(context).textTheme.headline4!.color),
      ),
      onTap: () {
        Get.to(() => AllMovies(asWidget: false, title: title));
      },
    );
  }

  SizedBox buildSectionBody() {
    return SizedBox(
      height: SizeConfig.screenHeight * 0.325,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                  left: index == 0 ? 20 : 0,
                  right: index == images.length - 1 ? 20 : 0),
              child: FilmCard(image: images[index]),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 20);
          },
          itemCount: images.length),
    );
  }
}
