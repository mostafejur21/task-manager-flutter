import 'package:get/get.dart';
import 'package:task_manager_flutter/data/models/network_response.dart';
import 'package:task_manager_flutter/data/services/network_caller.dart';
import 'package:task_manager_flutter/data/utils/api_links.dart';

class ResetPasswordController extends GetxController {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<bool> resetPassword(String email, String otp, String password) async {
    _isLoading = true;
    update();

    Map<String, dynamic> resetForm = {
      'email': email,
      'otp': otp,
      'password': password,
    };
    NetworkResponse response = await NetworkCaller()
        .postRequest(ApiLinks.recoverResetPassword, resetForm);
    _isLoading = false;
    update();
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
}
