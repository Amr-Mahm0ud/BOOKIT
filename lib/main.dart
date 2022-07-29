import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movie_app/controllers/home_controller.dart';
import 'package:movie_app/widgets/welcome/logo.dart';

import 'constants/consts.dart';
import 'constants/size.dart';
import 'constants/themes.dart';
import 'controllers/auth/auth_controller.dart';
import 'controllers/theme_services.dart';

void main() async {
  Get.put(HomeController());
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await firebaseInitialization.then((value) {
    Get.put(AuthController());
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Builder(builder: (context) {
        SizeConfig().init(context);
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
        );
      }),
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
