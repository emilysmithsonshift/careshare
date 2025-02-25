import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../style/style.dart';
import '../../domain/models/task.dart';
import '../../domain/usecases/all_task_usecases.dart';
import '../edit_task_screen.dart';
import '../accept_task_screen.dart';
import '../../../widgets/item_widget.dart';
import 'package:careshare/global.dart';

class TaskDetailWidget extends StatelessWidget {
  final CareTask task;
  const TaskDetailWidget({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    task.comments?.sort((a, b) => a.dateCreated!.compareTo(b.dateCreated!));

    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(6),
      decoration: Style.boxDecoration,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              itemWidget(
                title: 'Caregroup',
                content: (careeInCaregroups + carerInCaregroups).firstWhere((element) => element.id == task.caregroupId).name!,
              ),
              itemWidget(
                title: 'Title',
                content: task.title,
              ),
              itemWidget(
                title: 'Details',
                content: task.details,
              ),
              itemWidget(
                title: 'Size',
                content: task.taskSize.size,
              ),
              itemWidget(
                title: 'Created',
                content:
                DateFormat('dd-MM-yyyy – kk:mm').format(task.dateCreated!),
              ),

              if(task.taskAcceptedForDate != null) itemWidget(
                title: 'Accepted For Date',
                content:
                DateFormat('dd-MM-yyyy – kk:mm').format(task.taskAcceptedForDate!),
              ) ,

              if(task.acceptedBy != "")  itemWidget(
                title: 'Accepted By',
                content: task.acceptedByDisplayName ?? 'Anonymous',
              ),
              itemWidget(
                title: 'Created By',
                content: task.createdByDisplayName ?? 'Anonymous',
              ),
              itemWidget(
                  title: 'Status',
                  content: task.taskStatus.status
              ),

              if (task.comments != null) Text("Comments"),
              if (task.comments != null) Column(
                children: task.comments!.map((e) => Text(e.toString())).toList(),
              ),

              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditTaskScreen(
                              task: task,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.grey,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        AllTaskUseCases.removeTask(task.id!);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.grey,
                      ),
                    ),


                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AcceptTaskScreen(
                              task: task,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.adjust,
                        color: Colors.grey,
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.circle,
                        color: task.taskPriority.color,
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),



        ],
      ),
    );
  }
}
