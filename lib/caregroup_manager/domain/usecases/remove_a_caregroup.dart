import 'package:careshare/caregroup_manager/domain/errors/caregroup_manager_exception.dart';
import 'package:careshare/caregroup_manager/domain/repositories/caregroup_repository.dart';
import 'package:dartz/dartz.dart';

class RemoveCaregroup {
  final CaregroupRepository repository;

  RemoveCaregroup(this.repository);

  Future<Either<CaregroupManagerException, bool>> call(String caregroupId) {
    return repository.removeACaregroup(caregroupId);
  }
}
