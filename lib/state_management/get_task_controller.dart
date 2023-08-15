import 'package:get/get.dart';
import 'package:task_manager_flutter/data/models/network_response.dart';
import 'package:task_manager_flutter/data/services/network_caller.dart';

class GetTaskController extends GetxController {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<bool> getTask(String apiLink) async {
    _isLoading = true;
    update();
    final NetworkResponse response = await NetworkCaller().getRequest(apiLink);
    _isLoading = false;
    update();
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
}
