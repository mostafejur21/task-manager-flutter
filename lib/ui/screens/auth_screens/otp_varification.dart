import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_flutter/state_management/otp_verification_controller.dart';
import 'package:task_manager_flutter/ui/screens/auth_screens/reset_screen.dart';
import 'package:task_manager_flutter/ui/widgets/custom_button.dart';
import 'package:task_manager_flutter/ui/widgets/screen_background.dart';
import 'package:task_manager_flutter/ui/widgets/signup_button.dart';

import 'login_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({
    Key? key,
    required this.email,
  }) : super(key: key);
  final String email;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text(
                  "PIN VERIFICATION",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  "A 6 digit code has been sent to your email address. Please enter it below to continue.",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                const SizedBox(height: 16),
                Form(
                  key: _otpFormKey,
                  child: PinCodeTextField(
                    controller: _otpTEController,
                    appContext: context,
                    length: 6,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    cursorColor: Colors.green,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      borderWidth: 0.5,
                      fieldWidth: 50,
                      inactiveFillColor: Colors.white,
                      inactiveColor: Colors.white,
                      activeColor: Colors.white,
                      selectedColor: Colors.green,
                      selectedFillColor: Colors.white,
                      activeFillColor: Colors.white,
                    ),
                  ),
                ),
                GetBuilder<OtpVerificationController>(
                    builder: (otpVerificationController) {
                  return Visibility(
                    visible: otpVerificationController.isLoading == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: CustomButton(
                      onPresse: () {
                        otpVerificationController
                            .otpVerify(
                                widget.email, _otpTEController.text.trim())
                            .then((results) {
                          if (results == true) {
                            Get.off(ResetPasswordScreen(
                                email: widget.email,
                                otp: _otpTEController.text.trim()));
                          }
                        });
                      },
                    ),
                  );
                }),
                const SizedBox(
                  height: 16,
                ),
                SignUpButton(
                  text: "Have An Account?",
                  onPresse: () {
                    Get.to(const LoginScreen());
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
