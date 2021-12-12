import '../create_or_edit_task/create_or_edit_task_screen.dart';
import '../task_manager/task_manager_screen.dart';
import 'package:flutter/material.dart';

import '../../../widgets/job_summary_widget.dart';
import '../../domain/models/task.dart';

class TaskEnteredScreen extends StatelessWidget {
  final CareTask task;
  const TaskEnteredScreen({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thank you for entering a task',
        ),
      ),
      body: Column(
        children: [
          JobSummaryWidget(
            task: task,
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateOrEditATaskScreen()));
            },
            child: const Text('Create a new task'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TaskManagerScreen(),
                ),
              );
            },
            child: const Text('View all tasks'),
          ),
        ],
      ),
    );
  }
}
