import 'package:dartz/dartz.dart';
import 'package:geny_test/core/exception/app_exception.dart';

abstract class ItemRepository<T> {
  const ItemRepository();

  Future<Either<AppException, List<T>>> getAll();
}
