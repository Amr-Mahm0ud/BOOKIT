import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';

import 'package:get/get.dart';
import 'package:movie_app/constants/size.dart';
import 'package:movie_app/models/user.dart';
import 'package:movie_app/widgets/input_field.dart';
import 'package:movie_app/widgets/welcome/logo.dart';

import '../../constants/auth_consts.dart';
import '../../widgets/welcome/button.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  UserModel user = UserModel(
    email: '',
    name: '',
    phone: '',
    password: '',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth * 0.1,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                //logo
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.screenHeight * 0.02),
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
                //name
                InputField(
                  hint: 'User Name',
                  onSave: (val) {
                    user.name = val!;
                    return null;
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'User name is required';
                    }
                    return null;
                  },
                  keyType: TextInputType.name,
                ),
                //email
                InputField(
                  hint: 'Email',
                  onSave: (val) {
                    user.email = val!;
                    return null;
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                  keyType: TextInputType.emailAddress,
                ),
                //password
                InputField(
                  hint: 'Password',
                  onSave: (val) {
                    user.password = val!;
                    return null;
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  keyType: TextInputType.visiblePassword,
                ),
                //phone
                InputField(
                  hint: 'Phone',
                  onSave: (val) {
                    user.phone = val!;
                    return null;
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Phone is required';
                    }
                    return null;
                  },
                  keyType: TextInputType.phone,
                ),
                //button
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.screenHeight * 0.03),
                  child: Button(
                    onPressed: () {
                      bool isValid = _formKey.currentState!.validate();
                      if (isValid) {
                        _formKey.currentState!.save();
                        authController.register(user);
                      }
                    },
                    label: 'Register',
                  ),
                ),
                //or
                Row(
                  children: const [
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('or register with'),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                //social buttons
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.screenHeight * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlutterSocialButton(
                        mini: true,
                        buttonType: ButtonType.google,
                        onTap: () {},
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
