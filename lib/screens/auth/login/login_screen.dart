// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/auth/widgets/custom_button.dart';
import 'package:shop_app/screens/auth/widgets/custom_text_field.dart';
import 'package:shop_app/utils/styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late TextEditingController _emailController = TextEditingController(text: '');
  late TextEditingController _passController = TextEditingController(text: '');
  bool isSecurePassword = true;
  GlobalKey<FormState> formKey = GlobalKey();
  // ignore: unused_field
  static String id = 'LoginScreen';

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationListener) {
            if (animationListener == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: Stack(
          children: [
            CachedNetworkImage(
              imageUrl:
                  "https://th.bing.com/th/id/OIP.84UzNIsqNeHdkxyR5F1RlgHaHa?pid=ImgDet&w=178&h=178&c=7&dpr=1.3",
              placeholder: (context, url) => Image.asset(
                'assets/images/wallpaper.jpg',
                fit: BoxFit.fill,
              ),
              errorWidget: (context, url, error) =>const Icon(Icons.error),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              alignment: FractionalOffset(_animation.value, 0),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  const Text(
                    'Login',
                    style: Styles.authenticationText30,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                            text: 'Dont Have an Account?  ',
                            style: Styles.authenticationText15),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context)
                                  .pushReplacementNamed('SignUpScreen');
                            },
                          text: 'SignUp',
                          style: Styles.authenticationText15.copyWith(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  CustomTextFormField(
                    controller: _emailController,
                    hint: 'Email',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field is empty';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (p0) {},
                    obscureText: false,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  CustomTextFormField(
                    suffixIcon: passwordShow(),
                    controller: _passController,
                    hint: 'Password',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field is empty';
                      }
                      if (value.length < 7) {
                        return 'Password must be more than 7 letters';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (p0) {},
                    obscureText: isSecurePassword,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed('ForgetPasswordScreen');
                      },
                      child: Text(
                        'Forget Passsword?',
                        style: Styles.authenticationText15.copyWith(
                            decoration: TextDecoration.underline,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  CustomButton(
                      text: 'Login',
                      backgroundColor: Styles.buttonColor,
                      borderSideColor: Colors.transparent,
                      style: Styles.authenticationText15,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          print('valid');
                        } else {
                          print('not valid');
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget passwordShow() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSecurePassword = !isSecurePassword;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
        child: Icon(
          isSecurePassword ? Icons.visibility : Icons.visibility_off,
          color: Colors.white,
        ),
      ),
    );
  }
}
