import 'package:careshare/task_manager/presenter/task_widgets/select_caregroup.dart';
import 'package:careshare/widgets/custom_app_bar.dart';
import 'package:careshare/widgets/custom_drawer.dart';

import '../domain/models/task_priority.dart';
import 'package:flutter/material.dart';

import '../../style/style.dart';
import '../../widgets/custom_form_field.dart';
import '../domain/models/task.dart';
import '../domain/models/task_size.dart';
import 'task_widgets/select_priority.dart';
import 'task_widgets/select_task_size.dart';
import 'edit_task_controller.dart';

class EditTaskScreen extends StatefulWidget {
  final CareTask task;
  const EditTaskScreen({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<EditTaskScreen> createState() =>
      _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late EditTaskController controller = EditTaskController();
  bool showTaskTypeError = false;

  initialise() async {
    await controller.initialiseControllers(widget.task);
    setState(() {

    });
  }

  @override
  void initState() {
    initialise();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print('controller.caregroup?.name: ');
    // print(controller.caregroup);
    // print(controller.caregroup?.name);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: CustomAppBar('Edit a Task'),
      endDrawer: CustomDrawer(),
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [

                CustomFormField(
                  controller: controller.titleController,
                  label: 'Title',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Title';
                    }
                    return null;
                  },
                ),


                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(6),
                  padding: const EdgeInsets.all(6),
                  decoration: Style.boxDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectCaregroup(
                        onSelect: (String caregroup) {
                          controller.caregroup = controller.caregroupList.firstWhere((element) => element.name == caregroup);
                          setState(() {});
                        },
                        caregroupOptions: controller.caregroupOptions,
                        currentCaregroup: controller.caregroup?.name,
                      ),
                      Text(
                        showTaskTypeError ? 'Please select a task type' : '',
                        style: TextStyle(
                          color: Colors.red.shade600,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),


                CustomFormField(
                  controller: controller.detailsController,
                  maxLines: 8,
                  label: 'Details',
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the task details';
                    }
                    return null;
                  },
                ),





                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  padding:
                  const EdgeInsets.only(top: 16, left: 16, right: 16),
                  decoration: Style.boxDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectTaskSize(
                        onSelect: (TaskSize newTaskSize) {
                          controller.taskSize = newTaskSize;
                        },
                        currentSize: controller.taskSize,
                      ),
                      Text(
                        showTaskTypeError ? 'Please select a task size' : '',
                        style: TextStyle(
                          color: Colors.red.shade600,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
                SelectPriority(
                  onSelect: (TaskPriority priority) {
                    controller.priority = priority;
                  },
                ),
                TextButton(
                  onPressed: () {
                    controller.formKey.currentState?.validate();
                    if (controller.caregroup == null) {
                      setState(() {
                        showTaskTypeError = true;
                      });
                      return;
                    }
                    controller.createTask(
                      context: context,
                    );
                  },
                  child: Text('Save changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
