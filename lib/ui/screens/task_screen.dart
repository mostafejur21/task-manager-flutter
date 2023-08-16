// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_flutter/data/models/task_model.dart';
import 'package:task_manager_flutter/state_management/task_controller.dart';
import 'package:task_manager_flutter/ui/screens/add_task_screen.dart';
import 'package:task_manager_flutter/ui/widgets/screen_background.dart';
import 'package:task_manager_flutter/ui/widgets/status_change_bottom_sheet.dart';
import 'package:task_manager_flutter/ui/widgets/summery_card.dart';
import 'package:task_manager_flutter/ui/widgets/task_card.dart';
import 'package:task_manager_flutter/ui/widgets/user_banners.dart';

import 'update_profile.dart';

class TaskScreen extends StatefulWidget {
  final String screenStatus;
  final String apiLink;
  final bool showAllSummeryCard;
  final bool floatingActionButton;

  const TaskScreen({
    Key? key,
    required this.screenStatus,
    required this.apiLink,
    this.showAllSummeryCard = false,
    this.floatingActionButton = true,
  }) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  TaskController taskController = Get.find<TaskController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      taskController.getTask(widget.apiLink);
      taskController.statusCount();
    });
  }

  // int getCountForStatus(String status) {
  //   final Data? statusData = statusCountModel.data?.firstWhere(
  //     (data) => data.statusId == status,
  //     orElse: () => Data(statusId: status, count: 0),
  //   );
  //   return statusData?.count ?? 0;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: userBanner(
        context,
        onTapped: () {
          Get.to(() => const UpdateProfileScreen());
        },
      ),
      body: ScreenBackground(
        child: GetBuilder<TaskController>(builder: (_) {
          return Column(
            children: [
              if (widget.showAllSummeryCard)
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: Visibility(
                      visible: taskController.isLoading == false,
                      replacement: const Center(
                        child: LinearProgressIndicator(),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: SummeryCard(
                              numberOfTasks: taskController.count1,
                              title: "New",
                            ),
                          ),
                          Expanded(
                            child: SummeryCard(
                              numberOfTasks: taskController.count3,
                              title: "Completed",
                            ),
                          ),
                          Expanded(
                            child: SummeryCard(
                              numberOfTasks: taskController.count2,
                              title: "Cancelled",
                            ),
                          ),
                          Expanded(
                            child: SummeryCard(
                              numberOfTasks: taskController.count4,
                              title: "Progress",
                            ),
                          ),
                        ],
                      ),
                    )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      taskController.getTask(widget.apiLink);
                      taskController.statusCount();
                    },
                    child: Visibility(
                      visible: taskController.isLoading == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ListView.builder(
                          itemCount: taskController.taskModel.data?.length ?? 0,
                          itemBuilder: (context, int index) {
                            return CustomTaskCard(
                                title: taskController
                                        .taskModel.data![index].title ??
                                    "Unknown",
                                description: taskController
                                        .taskModel.data![index].description ??
                                    "",
                                createdDate: taskController
                                        .taskModel.data![index].createdDate ??
                                    "",
                                status: taskController
                                        .taskModel.data![index].status ??
                                    "NEW",
                                chipColor: _getChipColor(),
                                onChangeStatusPressed: () {
                                  statusUpdateBottomSheet(
                                      taskController.taskModel.data![index]);
                                },
                                onEditPressed: () {},
                                onDeletePressed: () {
                                  Get.defaultDialog(
                                    title: "delete task?",
                                    middleText:
                                        "Are you sure you want to delete this task?",
                                    textConfirm: "Yes",
                                    textCancel: "No",
                                    onCancel: () {
                                      Get.back();
                                    },
                                    onConfirm: () {
                                      taskController.deleteTask(taskController
                                          .taskModel.data![index].sId!);
                                      Get.back();
                                      taskController.getTask(widget.apiLink);
                                      taskController.statusCount();
                                    },
                                  );
                                });
                          }),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
      floatingActionButton: Visibility(
        visible: widget.floatingActionButton == true,
        child: FloatingActionButton(
          onPressed: () {
            Get.to(const AddTaskScreen());
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Color _getChipColor() {
    switch (widget.screenStatus) {
      case "New":
        return Colors.blue;
      case "Completed":
        return Colors.green;
      case "Cancelled":
        return Colors.red;
      case "In Progress":
        return Colors.pink.shade400;
      default:
        return Colors.grey;
    }
  }

  void statusUpdateBottomSheet(TaskData task) {
    showModalBottomSheet(
      shape: ShapeBorder.lerp(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.black)),
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.black)),
          1)!,
      context: context,
      builder: (context) {
        return UpdateStatus(
          task: task,
          onTaskComplete: () {
            taskController.getTask(widget.apiLink);
            taskController.statusCount();
          },
        );
      },
    );
  }
}
