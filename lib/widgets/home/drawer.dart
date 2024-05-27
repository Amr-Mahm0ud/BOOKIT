import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants/consts.dart';
import 'package:movie_app/controllers/booking_controller.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../controllers/home/theme_services.dart';
import '../../models/user.dart';
import '../../screens/booking/my_booking.dart';
import '../welcome/button.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = getUserData();
    return Drawer(
      width: Get.width,
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
                      radius: Get.width * 0.075,
                      backgroundImage: user.photoUrl != ''
                          ? NetworkImage(
                              user.photoUrl!,
                            )
                          : null,
                      child: user.photoUrl == ''
                          ? Icon(
                              Icons.person_rounded,
                              size: Get.width * 0.1,
                            )
                          : null),
                  const Spacer(flex: 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        user.email,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.white70,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  const Spacer(flex: 10),
                  SizedBox(
                    width: Get.width * 0.15,
                    height: Get.height * 0.085,
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      elevation: 10,
                      color: Colors.white,
                      shadowColor:
                          Theme.of(context).primaryColor.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Get.width),
                          bottomLeft: Radius.circular(Get.width),
                        ),
                      ),
                      child: IconButton(
                        icon: Image.asset(
                          'assets/images/menur.png',
                          color: Theme.of(context).primaryColor,
                          width: Get.width * 0.1,
                        ),
                        onPressed: () {
                          Get.back();
                          Get.delete<BookingController>();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.08),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.01,
                  horizontal: Get.width * 0.1,
                ),
                leading: RotationTransition(
                  turns: const AlwaysStoppedAnimation(90 / 360),
                  child: Icon(
                    Icons.local_movies_outlined,
                    color: Colors.white,
                    size: Get.width * 0.08,
                  ),
                ),
                title: Text(
                  'My Booking',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                ),
                trailing: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Get.theme.primaryColor,
                    size: 20,
                  ),
                ),
                onTap: () {
                  Get.put(BookingController());
                  Get.to(() => const MyBooking());
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.01,
                  horizontal: Get.width * 0.1,
                ),
                leading: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: Get.width * 0.08,
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
                  vertical: Get.height * 0.01,
                  horizontal: Get.width * 0.1,
                ),
                leading: Icon(
                  Icons.support_agent_rounded,
                  color: Colors.white,
                  size: Get.width * 0.08,
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
                  vertical: Get.height * 0.01,
                  horizontal: Get.width * 0.1,
                ),
                leading: Icon(
                  Icons.dark_mode,
                  color: Colors.white,
                  size: Get.width * 0.08,
                ),
                title: Text(
                  'DarkTheme',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                ),
                onTap: () {},
                trailing: CupertinoSwitch(
                  onChanged: (value) {
                    ThemeController().switchTheme();
                  },
                  value: Get.isDarkMode,
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.all(Get.height * 0.04),
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

  UserModel getUserData() {
    if (AuthController.firebaseUser.value != null) {
      var name = AuthController.firebaseUser.value!.displayName;
      return UserModel(
        name: name == null || name == ''
            ? AuthController.firebaseUser.value!.email!.split('@')[0]
            : AuthController.firebaseUser.value!.displayName!,
        email: AuthController.firebaseUser.value!.email!,
        photoUrl: AuthController.firebaseUser.value!.photoURL ?? '',
      );
    } else {
      return UserModel(
        name: AuthController.googleSignInAccount.value!.displayName!,
        email: AuthController.googleSignInAccount.value!.email,
        photoUrl: AuthController.googleSignInAccount.value!.photoUrl,
      );
    }
  }
}
