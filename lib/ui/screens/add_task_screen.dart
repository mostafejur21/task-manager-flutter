import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_flutter/state_management/add_task_controller.dart';
import 'package:task_manager_flutter/ui/widgets/custom_button.dart';
import 'package:task_manager_flutter/ui/widgets/custom_text_form_field.dart';
import 'package:task_manager_flutter/ui/widgets/screen_background.dart';
import 'package:task_manager_flutter/ui/widgets/user_banners.dart';

import 'update_profile.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskNameController = TextEditingController();

  final TextEditingController _taskDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: userBanner(context, onTapped: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const UpdateProfileScreen()));
      }),
      body: ScreenBackground(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Add Task",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      hintText: "Task Title",
                      controller: _taskNameController,
                      textInputType: TextInputType.text,
                      // validator: (value) {
                      //   if (value?.isEmpty ?? true) {
                      //     return "Please enter task title";
                      //   }
                      //   return null;
                      // },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      maxLines: 4,
                      hintText: "Description",
                      controller: _taskDescriptionController,
                      textInputType: TextInputType.text,
                      // validator: (value) {
                      //   if (value?.isEmpty ?? true) {
                      //     return "Please enter task description";
                      //   }
                      //   return null;
                      // },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GetBuilder<AddTaskController>(builder: (addTaskController) {
                      return Visibility(
                          visible: addTaskController.addNewTaskLoading == false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: CustomButton(
                            onPresse: () {
                              addTaskController
                                  .addNewTask(_taskNameController.text.trim(),
                                      _taskDescriptionController.text.trim())
                                  .then((value) {
                                if (value == true) {
                                  _taskNameController.clear();
                                  _taskDescriptionController.clear();
                                  Get.snackbar(
                                      "Success", "New Task added successfully");
                                } else {
                                  Get.snackbar(
                                      "Failed", "New Task added failed");
                                }
                              });
                            },
                          ));
                    }),
                  ],
                )),
          ],
        ),
      )),
    );
  }
}
