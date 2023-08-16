import 'package:get/get.dart';
import 'package:task_manager_flutter/data/models/network_response.dart';
import 'package:task_manager_flutter/data/models/task_model.dart';
import 'package:task_manager_flutter/data/services/network_caller.dart';
import 'package:task_manager_flutter/data/utils/api_links.dart';

class TaskController extends GetxController {
  TaskListModel _taskModel = TaskListModel();
  bool _isLoading = false;

  TaskListModel get taskModel => _taskModel;

  bool get isLoading => _isLoading;

  Future<void> getTask(String apiLink) async {
    _isLoading = true;
    update();
    final NetworkResponse response = await NetworkCaller().getRequest(apiLink);
    _isLoading = false;
    update();
    if (response.isSuccess && response.statusCode == 200) {
      _taskModel = TaskListModel.fromJson(response.body!);
    } else {
      Get.snackbar("Failed", "Failed to load tasks");
    }
  }

  Future<bool> deleteTask(String taskId) async {
    _isLoading = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(ApiLinks.deleteTask(taskId));
    _isLoading = false;
    update();
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
}
