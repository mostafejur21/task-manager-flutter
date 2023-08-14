import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_flutter/state_management/reset_pass_controller.dart';
import 'package:task_manager_flutter/ui/screens/auth_screens/login_screen.dart';
import 'package:task_manager_flutter/ui/widgets/custom_button.dart';
import 'package:task_manager_flutter/ui/widgets/custom_password_text_field.dart';
import 'package:task_manager_flutter/ui/widgets/screen_background.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;

  const ResetPasswordScreen({
    Key? key,
    required this.email,
    required this.otp,
  }) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  final GlobalKey<FormState> _resetFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            key: _resetFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Set your password",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  'Minimum length is 8 characters with number and character combination',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomPasswordTextFormField(
                  controller: _passwordTEController,
                  hintText: "Password",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomPasswordTextFormField(
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return "Please enter confirm password";
                    } else if (value! != _passwordTEController.text) {
                      return "Password does not match";
                    }
                    return null;
                  },
                  controller: _confirmPasswordTEController,
                  hintText: "Confirm Password",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 16,
                ),
                GetBuilder<ResetPasswordController>(
                    builder: (resetPasswordController) {
                  return Visibility(
                    visible: resetPasswordController.isLoading == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: CustomButton(
                      onPresse: () {
                        if (_resetFormKey.currentState!.validate() &&
                            _passwordTEController.text ==
                                _confirmPasswordTEController.text) {
                          resetPasswordController
                              .resetPassword(widget.email, widget.otp,
                                  _passwordTEController.text)
                              .then((results) {
                            if (results == true) {
                              Get.offAll(const LoginScreen());
                            } else {
                              Get.snackbar("Error", "Password reset failed");
                            }
                          });
                        } else {
                          Get.snackbar(
                              "Failed", "Please enter correct password");
                        }
                      },
                    ),
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Have an Account?",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(letterSpacing: .7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
