import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movie_app/controllers/home_controller.dart';
import 'package:movie_app/screens/welcome.dart';

import 'constants/themes.dart';
import 'controllers/theme_services.dart';

void main() async {
  Get.put(HomeController());
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme.copyWith(
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Nunito'),
      ),
      darkTheme: Themes.darkTheme.copyWith(
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Nunito',
            ),
      ),
      themeMode: ThemeController().theme,
    );
  }
}
