import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/widgets/input_field.dart';

import '../../constants/size.dart';
import '../../widgets/welcome/button.dart';
import '../../widgets/welcome/logo.dart';
import '../home/main_page.dart';

class SignIN extends StatefulWidget {
  const SignIN({Key? key}) : super(key: key);

  @override
  State<SignIN> createState() => _SignINState();
}

class _SignINState extends State<SignIN> {
  final GlobalKey<FormState> _formKey = GlobalKey();

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
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.1),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                //logo
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.screenHeight * 0.07),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Logo(size: SizeConfig.screenWidth * 0.07),
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
                      return null;
                    },
                    hint: 'Password'),
                //forgot password
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.screenHeight * 0.025),
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
                    _formKey.currentState!.validate();
                    Get.offAll(const MainPage());
                  },
                  label: 'Login',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
