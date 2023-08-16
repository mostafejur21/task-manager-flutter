import 'package:get/get.dart';
import 'package:task_manager_flutter/data/models/network_response.dart';
import 'package:task_manager_flutter/data/models/summery_count_model.dart';
import 'package:task_manager_flutter/data/models/task_model.dart';
import 'package:task_manager_flutter/data/services/network_caller.dart';
import 'package:task_manager_flutter/data/utils/api_links.dart';

class TaskController extends GetxController {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  TaskListModel _taskModel = TaskListModel();
  TaskListModel get taskModel => _taskModel;
  Future<bool> getTask(String apiLinks) async {
    _isLoading = true;
    update();
    final NetworkResponse response = await NetworkCaller().getRequest(apiLinks);
    _isLoading = false;
    if (response.isSuccess) {
      _taskModel = TaskListModel.fromJson(response.body!);
      update();
      return true;
    } else {
      Get.snackbar("Failed", "task load failed");
      update();
      return false;
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

  final StatusCountModel _statusCountModel = StatusCountModel();
  StatusCountModel get statusCountModel => _statusCountModel;
  int count1 = 0;
  int count2 = 0;
  int count3 = 0;
  int count4 = 0;
  Future<void> statusCount() async {
    _isLoading = true;
    update();
    final NetworkResponse newTaskResponse =
        await NetworkCaller().getRequest(ApiLinks.newTaskStatus);
    TaskListModel newTaskModel = TaskListModel.fromJson(newTaskResponse.body!);

    count1 = newTaskModel.data?.length ?? 0;
    update();

    final cancelledTaskResponse =
        await NetworkCaller().getRequest(ApiLinks.cancelledTaskStatus);
    TaskListModel cancelledTaskModel =
        TaskListModel.fromJson(cancelledTaskResponse.body!);
    count2 = cancelledTaskModel.data?.length ?? 0;
    update();

    final completedTaskResponse =
        await NetworkCaller().getRequest(ApiLinks.completedTaskStatus);

    TaskListModel completedTaskModel =
        TaskListModel.fromJson(completedTaskResponse.body!);
    count3 = completedTaskModel.data?.length ?? 0;
    update();

    final inProgressResponse =
        await NetworkCaller().getRequest(ApiLinks.inProgressTaskStatus);
    TaskListModel inProgressTaskModel =
        TaskListModel.fromJson(inProgressResponse.body!);
    count4 = inProgressTaskModel.data?.length ?? 0;
    update();

    _isLoading = false;
    update();
  }

  void screenUpdate() {
    update();
  }
}
