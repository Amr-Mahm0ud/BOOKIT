import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movie_app/screens/welcome.dart';

import 'constants/themes.dart';
import 'controllers/theme_services.dart';

void main() async {
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
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: ThemeController().theme,
    );
  }
}
