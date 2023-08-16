// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_flutter/data/models/task_model.dart';
import 'package:task_manager_flutter/state_management/update_status_controller.dart';
import 'package:task_manager_flutter/ui/widgets/custom_button.dart';

class UpdateStatus extends StatefulWidget {
  final TaskData task;
  const UpdateStatus(
      {super.key, required this.task, required this.onTaskComplete});
  final VoidCallback onTaskComplete;

  @override
  State<UpdateStatus> createState() => _UpdateStatusState();
}

class _UpdateStatusState extends State<UpdateStatus> {
  // List<String> taskStatusList = ['New', 'Progress', 'Canceled', 'Completed'];
  late String _selectedTask;
  // bool updateTaskInProgress = false;
  UpdateStatusController updateStatusController =
      Get.find<UpdateStatusController>();

  @override
  void initState() {
    _selectedTask = widget.task.status!.toLowerCase();
    super.initState();
  }

  // Future<void> updateTask(String taskId, String newStatus) async {
  //   updateTaskInProgress = true;
  //   if (mounted) {
  //     setState(() {});
  //   }
  //   NetworkResponse response = await NetworkCaller()
  //       .getRequest(ApiLinks.updateTask(taskId, newStatus));
  //   updateTaskInProgress = false;
  //   if (mounted) {
  //     setState(() {});
  //   }
  //   if (response.isSuccess) {
  //     widget.onTaskComplete();
  //     Get.back();
  //   } else {
  //     Get.snackbar("failed", "Status update failed");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateStatusController>(builder: (_) {
      return Column(
        children: [
          const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Update Status',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
              )),
          Expanded(
            child: ListView(
              children: [
                for (int index = 0;
                    index < updateStatusController.taskStatusList.length;
                    index++)
                  RadioListTile<String>(
                    value: updateStatusController.taskStatusList[index],
                    groupValue: _selectedTask,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedTask = value!;
                      });
                    },
                    title: Text(updateStatusController.taskStatusList[index]
                        .toUpperCase()),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Visibility(
              visible: !updateStatusController.updateTaskInProgress,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: CustomButton(
                onPresse: () {
                  updateStatusController
                      .updateTask(widget.task.sId!, _selectedTask)
                      .then((value) {
                    if (value == true) {
                      widget.onTaskComplete();
                    }
                  });
                },
              ),
            ),
          )
        ],
      );
    });
  }
}
