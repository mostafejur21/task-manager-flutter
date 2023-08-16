import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_flutter/data/models/network_response.dart';
import 'package:task_manager_flutter/data/services/network_caller.dart';
import 'package:task_manager_flutter/data/utils/api_links.dart';

class UpdateStatusController extends GetxController {
  final List<String> _taskStatusList = ['New', 'Progress', 'Canceled', 'Completed'];
  List<String> get taskStatusList => _taskStatusList;

  bool _updateTaskInProgress = false;
  bool get updateTaskInProgress => _updateTaskInProgress;
  Future<bool> updateTask(String taskId, String newStatus) async {
    _updateTaskInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller()
        .getRequest(ApiLinks.updateTask(taskId, newStatus));
    _updateTaskInProgress = false;
    update();
    if (response.isSuccess) {
      Get.back();
      return true;
    } else {
      Get.snackbar("failed", "Status update failed");
      return false;
    }
  }
}
