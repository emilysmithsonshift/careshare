import 'package:firebase_database/firebase_database.dart';

import '../../domain/models/task.dart';

abstract class TaskDatasource {
  Future<String> createTask(CareTask task);
  Future<DatabaseEvent> fetchAllTasks();
  Future<DatabaseEvent> fetchSomeTasks(String search);
  Future editTask(CareTask task);
  Future removeTask(String taskId);
  Future<String> addComment(
      {required Comment comment,
      required String taskId,
      required DateTime acceptedDateTime,
      required String profileId,
      String? displayName});
}
