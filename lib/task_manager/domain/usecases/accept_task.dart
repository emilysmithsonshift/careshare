import '../errors/task_manager_exception.dart';
import 'package:careshare/task_manager/domain/models/task.dart';
import 'package:careshare/task_manager/domain/repositories/task_repository.dart';
import 'package:dartz/dartz.dart';

class AcceptTask {
  final TaskRepository repository;
//task.taskAcceptedForDate = acceptedDateTime;
  // task.taskStatus = TaskStatus.accepted;

  // task.acceptedBy = myProfile.id;
  // task.acceptedByDisplayName = myProfile.displayName ?? 'anonymous';

  AcceptTask(this.repository);
  Future<Either<TaskManagerException, String>> call(
      {required Comment comment,
      required String taskId,
      required DateTime acceptedDateTime,
      required String profileId,
      String? displayName}) {
    return repository.acceptTask(
      comment: comment,
      taskId: taskId,
      acceptedDateTime: acceptedDateTime,
      profileId: profileId,
      displayName: displayName,
    );
  }
}
