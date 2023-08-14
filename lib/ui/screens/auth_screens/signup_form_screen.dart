import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_flutter/state_management/signup_form_controller.dart';
import 'package:task_manager_flutter/ui/widgets/custom_button.dart';
import 'package:task_manager_flutter/ui/widgets/custom_text_form_field.dart';
import 'package:task_manager_flutter/ui/widgets/screen_background.dart';

class SignUpFormScreen extends StatefulWidget {
  const SignUpFormScreen({super.key});

  @override
  State<SignUpFormScreen> createState() => _SignUpFormScreenState();
}

class _SignUpFormScreenState extends State<SignUpFormScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text(
                  "Join Us",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextFormField(
                  controller: _emailController,
                  hintText: 'Email',
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[\w-.]+@([\w-]+\.)+\w{2,5}')
                            .hasMatch(value)) {
                      return 'Email is required';
                    }
                    return null;
                  },
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextFormField(
                  controller: _firstNameController,
                  hintText: 'First Name',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your first name';
                    }
                    return null;
                  },
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextFormField(
                  controller: _lastNameController,
                  hintText: 'Last Name',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your last name';
                    }
                    return null;
                  },
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextFormField(
                  controller: _phoneNumberController,
                  hintText: 'Phone Number',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your Valid Phone Number';
                    }
                    return null;
                  },
                  textInputType: TextInputType.number,
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextFormField(
                  controller: _passwordController,
                  hintText: 'Password',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your password';
                    }
                    return null;
                  },
                  textInputType: TextInputType.text,
                  obscureText: true,
                ),
                const SizedBox(height: 12),
                GetBuilder<SignupController>(builder: (signupController) {
                  return Visibility(
                    visible: signupController.signUpInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: CustomButton(
                      onPresse: () {
                        if (_formKey.currentState!.validate()) {
                          signupController
                              .userSignUp(
                                  _emailController.text.trim(),
                                  _firstNameController.text.trim(),
                                  _lastNameController.text.trim(),
                                  _phoneNumberController.text.trim(),
                                  _passwordController.text)
                              .then((results) {
                            if (results == true) {
                              _emailController.clear();
                              _firstNameController.clear();
                              _lastNameController.clear();
                              _phoneNumberController.clear();
                              _passwordController.clear();
                              Get.snackbar(
                                  "Success", "Registration Successful");
                            } else {
                              Get.snackbar("Failed", "Registration Failed");
                            }
                          });
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
                        Get.back();
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
