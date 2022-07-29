import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_app/models/user.dart';
import 'package:movie_app/screens/home/main_page.dart';
import 'package:movie_app/screens/welcome.dart';

import '../../constants/consts.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;
  late Rx<GoogleSignInAccount?> googleSignInAccount;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);

    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);

    googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSignInAccount, _setInitialScreenGoogle);
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) async {
    if (googleSignInAccount == null) {
      Get.offAll(() => const WelcomeScreen());
    } else {
      await store
          .collection('users')
          .doc(googleSignInAccount.id)
          .get()
          .then((value) {
        if (value.exists) {
          Get.offAll(() => const MainPage());
        }
      });
    }
  }

  _setInitialScreen(User? user) async {
    if (user == null) {
      Get.offAll(() => const WelcomeScreen());
    } else {
      await store
          .collection('users')
          .doc(firebaseUser.value!.uid)
          .get()
          .then((value) {
        if (value.exists) {
          Get.offAll(() => const MainPage());
        }
      });
    }
  }

  void signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await auth.signInWithCredential(credential).catchError(
          (onErr) {
            Get.snackbar(
              'Error',
              onErr.toString(),
            );
          },
        ).then((value) async {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(value.user!.uid)
              .set({
            'email': value.user!.email,
            'name': value.user!.displayName,
            'image': value.user!.photoURL,
          }).catchError((onErr) async {
            await value.user!.delete();
            Get.snackbar(
              'Error',
              onErr.toString(),
            );
          });
        });
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    }
  }

  void register(UserModel user) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: user.email,
        password: user.password!,
      )
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(value.user!.uid)
            .set({
          'email': user.email,
          'name': user.name,
          'image': '',
        }).catchError((onErr) async {
          value.user!.delete();
          Get.snackbar(
            'Error',
            onErr.toString(),
          );
        });
      });
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
