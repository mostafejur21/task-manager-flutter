import 'package:get/get.dart';
import 'package:task_manager_flutter/data/models/auth_utility.dart';
import 'package:task_manager_flutter/data/models/login_model.dart';
import 'package:task_manager_flutter/data/models/network_response.dart';
import 'package:task_manager_flutter/data/services/network_caller.dart';
import 'package:task_manager_flutter/data/utils/api_links.dart';

class LoginController extends GetxController {
  bool _loginInProgress = false;

  bool get loginInProgress => _loginInProgress;

  Future<bool> login(String email, String password) async {
    _loginInProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
    };
    final NetworkResponse response =
        await NetworkCaller().postRequest(ApiLinks.login, requestBody);
    _loginInProgress = false;
    update();
    if (response.isSuccess) {
      await AuthUtility.setUserInfo(LoginModel.fromJson(response.body!));
      return true;
    } else {
      return false;
    }
  }
}
