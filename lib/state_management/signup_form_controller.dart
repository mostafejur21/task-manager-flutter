import 'package:get/get.dart';
import 'package:task_manager_flutter/data/models/network_response.dart';
import 'package:task_manager_flutter/data/services/network_caller.dart';
import 'package:task_manager_flutter/data/utils/api_links.dart';

class SignupController extends GetxController {
  bool _signUpInProgress = false;

  bool get signUpInProgress => _signUpInProgress;

  Future<bool> userSignUp(String email, String firstName, String lastName,
      String phoneNumber, String password) async {
    _signUpInProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "password": password,
      "photos": ""
    };

    final NetworkResponse response =
        await NetworkCaller().postRequest(ApiLinks.regestration, requestBody);
    _signUpInProgress = false;
    update();
    if (response.isSuccess && response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
