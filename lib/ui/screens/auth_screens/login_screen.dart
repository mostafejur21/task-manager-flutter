import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_flutter/state_management/login_controller.dart';
import 'package:task_manager_flutter/ui/screens/auth_screens/signup_form_screen.dart';
import 'package:task_manager_flutter/ui/screens/bottom_navbar_screen.dart';
import 'package:task_manager_flutter/ui/widgets/custom_button.dart';
import 'package:task_manager_flutter/ui/widgets/custom_password_text_field.dart';
import 'package:task_manager_flutter/ui/widgets/custom_text_form_field.dart';
import 'package:task_manager_flutter/ui/widgets/screen_background.dart';
import 'package:task_manager_flutter/ui/widgets/signup_button.dart';

import 'email_verification_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text(
                  "Getting Start With",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                    hintText: "Email",
                    controller: _emailController,
                    textInputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter email";
                      }
                      return null;
                    }),
                const SizedBox(height: 12),
                CustomPasswordTextFormField(
                  hintText: "Password",
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter password";
                    }
                    return null;
                  },
                  textInputType: TextInputType.visiblePassword,
                ),
                const SizedBox(
                  height: 16,
                ),
                GetBuilder<LoginController>(builder: (loginController) {
                  return Visibility(
                    visible: loginController.loginInProgress == false,
                    replacement:
                        const Center(child: CircularProgressIndicator()),
                    child: CustomButton(
                      onPresse: () {
                        loginController
                            .login(_emailController.text.trim(),
                                _passwordController.text)
                            .then((results) {
                          if (results == true) {
                            Get.offAll(const BottomNavBarScreen());
                          } else {
                            Get.snackbar(
                                "Failed", "Login Failed, please try again!");
                          }
                        });
                      },
                    ),
                  );
                }),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Get.to(const EmailVerificationScreen());
                    },
                    child: const Text(
                      "Forget Password?",
                      style: TextStyle(color: Colors.grey, letterSpacing: .7),
                    ),
                  ),
                ),
                SignUpButton(
                  text: "Don't have An Account?",
                  onPresse: () {
                    Get.to(const SignUpFormScreen());
                  },
                  buttonText: 'Sign Up',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
