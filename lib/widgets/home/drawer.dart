import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants/consts.dart';

import '../../constants/size.dart';
import '../../controllers/theme_services.dart';
import '../welcome/button.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: SizeConfig.screenWidth,
      backgroundColor: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(flex: 3),
                  CircleAvatar(
                    radius: SizeConfig.screenWidth * 0.075,
                    backgroundImage: const AssetImage('assets/images/1.jpg'),
                  ),
                  const Spacer(flex: 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Amr',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        'Edit your profile',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Colors.white70,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  const Spacer(flex: 10),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.15,
                    height: SizeConfig.screenHeight * 0.085,
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      elevation: 10,
                      color: Colors.white,
                      shadowColor:
                          Theme.of(context).primaryColor.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(SizeConfig.screenWidth),
                          bottomLeft: Radius.circular(SizeConfig.screenWidth),
                        ),
                      ),
                      child: IconButton(
                        icon: Image.asset(
                          'assets/images/menur.png',
                          color: Theme.of(context).primaryColor,
                          width: SizeConfig.screenWidth * 0.1,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.08),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: SizeConfig.screenHeight * 0.01,
                  horizontal: SizeConfig.screenWidth * 0.1,
                ),
                leading: RotationTransition(
                  turns: const AlwaysStoppedAnimation(90 / 360),
                  child: Icon(
                    Icons.local_movies_outlined,
                    color: Colors.white,
                    size: SizeConfig.screenWidth * 0.08,
                  ),
                ),
                title: Text(
                  'My Booking',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                ),
                trailing: const CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: Text('1'),
                ),
                onTap: () {},
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: SizeConfig.screenHeight * 0.01,
                  horizontal: SizeConfig.screenWidth * 0.1,
                ),
                leading: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: SizeConfig.screenWidth * 0.08,
                ),
                title: Text(
                  'Settings',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                ),
                onTap: () {},
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: SizeConfig.screenHeight * 0.01,
                  horizontal: SizeConfig.screenWidth * 0.1,
                ),
                leading: Icon(
                  Icons.support_agent_rounded,
                  color: Colors.white,
                  size: SizeConfig.screenWidth * 0.08,
                ),
                title: Text(
                  'Customer Support',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                ),
                onTap: () {},
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: SizeConfig.screenHeight * 0.01,
                  horizontal: SizeConfig.screenWidth * 0.1,
                ),
                leading: Icon(
                  Icons.dark_mode,
                  color: Colors.white,
                  size: SizeConfig.screenWidth * 0.08,
                ),
                title: Text(
                  'DarkTheme',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                ),
                onTap: () {
                  ThemeController().switchTheme();
                },
                trailing: CupertinoSwitch(
                  onChanged: (value) {},
                  value: Get.isDarkMode,
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.all(SizeConfig.screenHeight * 0.04),
                child: Button(
                  label: 'Logout',
                  onPressed: () {
                    authController.signOut();
                  },
                  border: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
