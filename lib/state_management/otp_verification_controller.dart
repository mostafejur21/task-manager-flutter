import 'package:get/get.dart';
import 'package:task_manager_flutter/data/models/network_response.dart';
import 'package:task_manager_flutter/data/services/network_caller.dart';
import 'package:task_manager_flutter/data/utils/api_links.dart';

class OtpVerificationController extends GetxController {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<bool> otpVerify(String email, String password) async {
    _isLoading = true;
    update();

    NetworkResponse response = await NetworkCaller()
        .getRequest(ApiLinks.recoverVerifyOTP(email, password));

    _isLoading = false;
    update();
    if (response.statusCode == 200 && response.body?['status'] == 'success') {
      return true;
    } else {
      return false;
    }
  }
}
