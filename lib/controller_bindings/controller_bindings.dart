import 'package:get/get.dart';
import 'package:task_manager_flutter/state_management/add_task_controller.dart';
import 'package:task_manager_flutter/state_management/email_verification_controller.dart';
import 'package:task_manager_flutter/state_management/login_controller.dart';
import 'package:task_manager_flutter/state_management/otp_verification_controller.dart';
import 'package:task_manager_flutter/state_management/reset_pass_controller.dart';
import 'package:task_manager_flutter/state_management/signup_form_controller.dart';
import 'package:task_manager_flutter/state_management/task_controller.dart';
import 'package:task_manager_flutter/state_management/update_profile_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(
        LoginController()); // Get.lazyPut<LoginController>(() => LoginController());
    Get.put<EmailVerificationController>(EmailVerificationController());
    Get.put<OtpVerificationController>(OtpVerificationController());
    Get.put<ResetPasswordController>(ResetPasswordController());
    Get.put<SignupController>(SignupController());
    Get.put<AddTaskController>(AddTaskController());
    Get.put<TaskController>(TaskController());
    Get.put<UpdateProfiController>(UpdateProfiController());
  }
}
