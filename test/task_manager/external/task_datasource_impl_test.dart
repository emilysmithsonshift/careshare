import 'package:careshare/task_manager/domain/models/task.dart';
import 'package:careshare/task_manager/external/task_datasource_impl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('task datasource impl ...', () async {
    Firebase.initializeApp();
    final taskDatasource = TaskDatasourceImpl();

    final response = await taskDatasource.createTask(
      CareTask(
        title: "test",
        // assigned: false,
        description: 'hello',
        createdBy: 'Emily',
        // taskType: TaskType.cleaning,
        // dueDate: DateTime(2022),
      ),
    );
    expect(response, isA<String>());
  });
}
