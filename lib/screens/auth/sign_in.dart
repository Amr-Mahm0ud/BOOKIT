import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants/consts.dart';
import 'package:movie_app/screens/auth/sign_up.dart';
import 'package:movie_app/widgets/input_field.dart';

import '../../widgets/welcome/button.dart';
import '../../widgets/welcome/logo.dart';

class SignIN extends StatefulWidget {
  const SignIN({Key? key}) : super(key: key);

  @override
  State<SignIN> createState() => _SignINState();
}

class _SignINState extends State<SignIN> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '', _password = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor!.withOpacity(0.95),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                //logo
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.height * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Logo(size: Get.width * 0.07),
                      const SizedBox(width: 15),
                      Text(
                        'BOOKIT',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
                //email
                InputField(
                    keyType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Email is required';
                      }
                      return null;
                    },
                    onSave: (val) {
                      _email = val!;
                      return null;
                    },
                    hint: 'Email'),
                // password
                InputField(
                    keyType: TextInputType.visiblePassword,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    onSave: (val) {
                      _password = val!;
                      return null;
                    },
                    hint: 'Password'),
                //forgot password
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.height * 0.025),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Forgot Password?'),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Reset',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
                ),
                //login
                Button(
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    bool isValid = _formKey.currentState!.validate();
                    if (isValid) {
                      _formKey.currentState!.save();
                      authController.login(_email, _password);
                    }
                    setState(() {
                      isLoading = false;
                    });
                  },
                  label: isLoading ? 'Loading...' : 'Login',
                ),
                //or
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.height * 0.03),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('or SignIn with'),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                //social buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlutterSocialButton(
                      mini: true,
                      buttonType: ButtonType.google,
                      onTap: () {
                        authController.signInWithGoogle();
                      },
                    ),
                    FlutterSocialButton(
                      mini: true,
                      buttonType: ButtonType.facebook,
                      onTap: () {},
                    ),
                    FlutterSocialButton(
                      mini: true,
                      buttonType: ButtonType.apple,
                      onTap: () {},
                    ),
                  ],
                ),
                //register
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('New user?'),
                    TextButton(
                      onPressed: () {
                        Get.off(() => const SignUp());
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
          ),
        ),
      ),
    );
  }
}
