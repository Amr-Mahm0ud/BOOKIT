import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:movie_app/models/user.dart';
import 'package:movie_app/screens/home/main_page.dart';
import 'package:movie_app/screens/welcome.dart';

import '../../constants/auth_consts.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);

    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const WelcomeScreen());
    } else {
      Get.offAll(() => const MainPage());
    }
  }

  void register(UserModel user) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password!,
      );
    } catch (firebaseAuthException) {
      Get.snackbar('Error', firebaseAuthException.toString());
    }
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (firebaseAuthException) {
      Get.snackbar('Error', firebaseAuthException.toString());
    }
  }

  void signOut() async {
    await auth.signOut();
  }
}
