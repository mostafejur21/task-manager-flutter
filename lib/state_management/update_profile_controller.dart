import 'package:get/get.dart';
import 'package:task_manager_flutter/data/models/network_response.dart';
import 'package:task_manager_flutter/data/services/network_caller.dart';
import 'package:task_manager_flutter/data/utils/api_links.dart';

class UpdateProfiController extends GetxController {
  bool _signUpInProgress = false;
  bool get updateProgress => _signUpInProgress;
  Future<bool> updateProfile(String email, String firstName, String lastName,
      String phoneNumber, String password) async {
    _signUpInProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "photos": ""
    };
    if (password.isNotEmpty) {
      requestBody["password"] = password;
    }
    final NetworkResponse response =
        await NetworkCaller().postRequest(ApiLinks.profileUpdate, requestBody);
    _signUpInProgress = false;
    update();
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
}
