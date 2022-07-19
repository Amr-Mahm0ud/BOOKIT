import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/screens/auth/sign_in.dart';

import '../constants/size.dart';
import '../widgets/welcome/button.dart';
import '../widgets/welcome/indicator.dart';
import '../widgets/welcome/logo.dart';
import 'auth/sign_up.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final List<String> images = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
    'assets/images/5.jpg',
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlayAnimationDuration: const Duration(milliseconds: 300),
              height: SizeConfig.screenHeight * 0.35,
              autoPlay: true,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              onPageChanged: (i, _) {
                setState(() {
                  index = i;
                });
              },
            ),
            items: images.map((image) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: SizeConfig.screenWidth,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          image,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Indicator(images: images, index: index),
          //Logo
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.04),
            child: Column(
              children: [
                Logo(size: SizeConfig.screenWidth * 0.13),
                const SizedBox(height: 5),
                Text(
                  'BOOKIT',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
          //Welcome Text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Enjoy best movies, events or activities via BOOKIT.',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
          ),
          //Button
          Padding(
            padding: EdgeInsets.all(SizeConfig.screenHeight * 0.04),
            child: Button(
              label: 'Login',
              onPressed: () {
                Get.to(() => const SignIN());
              },
            ),
          ),
          //Register
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('New user?'),
              TextButton(
                onPressed: () {
                  Get.to(() => const SignUp());
                },
                child: Text(
                  'Register here',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
