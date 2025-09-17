import 'package:dartz/dartz.dart';
import 'package:geny_test/core/exception/app_exception.dart';

typedef Result<T> = Either<AppException, T>;

typedef SuccessResult<T> = Right<AppException, T>;

typedef FailureResult<T> = Left<AppException, T>;
