import 'package:dartz/dartz.dart';
import 'package:geny_test/core/exception/app_exception.dart';

// ignore: one_member_abstracts
abstract class ItemRepository<T> {
  const ItemRepository();

  Future<Either<AppException, List<T>>> getAll();
}
