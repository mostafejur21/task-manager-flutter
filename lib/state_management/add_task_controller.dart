import 'package:get/get.dart';
import 'package:task_manager_flutter/data/models/network_response.dart';
import 'package:task_manager_flutter/data/services/network_caller.dart';
import 'package:task_manager_flutter/data/utils/api_links.dart';

class AddTaskController extends GetxController {
  bool _addNewTaskLoading = false;

  bool get addNewTaskLoading => _addNewTaskLoading;

  Future<bool> addNewTask(String title, String description) async {
    _addNewTaskLoading = true;
    update();
    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": "New",
    };
    final NetworkResponse response =
        await NetworkCaller().postRequest(ApiLinks.createTask, requestBody);
    _addNewTaskLoading = false;
    update();
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
}
