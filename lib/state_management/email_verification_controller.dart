import 'package:get/get.dart';
import 'package:task_manager_flutter/data/models/network_response.dart';
import 'package:task_manager_flutter/data/services/network_caller.dart';
import 'package:task_manager_flutter/data/utils/api_links.dart';

class EmailVerificationController extends GetxController {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<bool> emailVerify(String email) async {
    _isLoading = true;
    update();

    final NetworkResponse response =
        await NetworkCaller().getRequest(ApiLinks.recoverVerifyEmail(email));

    _isLoading = false;
    update();
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
}
