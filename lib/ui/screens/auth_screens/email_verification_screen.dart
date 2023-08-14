// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_flutter/ui/widgets/custom_text_form_field.dart';
import 'package:task_manager_flutter/ui/widgets/screen_background.dart';
import 'package:task_manager_flutter/ui/widgets/signup_button.dart';

import '../../../state_management/email_verification_controller.dart';
import '../../widgets/custom_button.dart';
import 'otp_varification.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  dispose() {
    super.dispose();
    _emailTEController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text(
                  "Your Email Address",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Please enter your email address to receive a verification code",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                const SizedBox(height: 16),
                Form(
                    key: _emailFormKey,
                    child: CustomTextFormField(
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[\w-.]+@([\w-]+\.)+\w{2,5}')
                                .hasMatch(value)) {
                          return "please Enter your correct Email";
                        } else {
                          return null;
                        }
                      },
                      hintText: "Email",
                      controller: _emailTEController,
                      textInputType: TextInputType.emailAddress,
                    )),
                const SizedBox(height: 12),
                GetBuilder<EmailVerificationController>(
                    builder: (emailVerificationController) {
                  return Visibility(
                    visible: emailVerificationController.isLoading == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: CustomButton(
                      onPresse: () {
                        if (_emailFormKey.currentState!.validate()) {
                          emailVerificationController
                              .emailVerify(_emailTEController.text.trim())
                              .then((results) {
                            if (results == true) {
                              Get.to(OtpVerificationScreen(
                                email: _emailTEController.text.trim(),
                              ));
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
                SignUpButton(
                  text: "Have An Account?",
                  onPresse: () {
                    Get.back();
                  },
                  buttonText: 'Login',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
