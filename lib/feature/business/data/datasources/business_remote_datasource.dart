import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:geny_test/core/core.dart';
import 'package:geny_test/core/exception/app_exception.dart';
import 'package:geny_test/core/logger/loggy_types.dart';
import 'package:geny_test/feature/business/data/model/business.dart';

class BusinessDioProvider extends DioHttpProvider with ProviderLoggy {
  BusinessDioProvider()
      : super(
          baseUrl: 'https://example.com', //https://genyapp.free.beeceptor.com/
        );

  Future<Either<AppException, List<Business>>> getAll() async {
    try {
      final response = await get('businesses/');

      if (response.statusCode == 200) {
        final rawData = response.data!;
        final businesses = rawData.map((item) => Business.fromJson(item as Map<String, dynamic>)).toList();
        return Right(businesses);
      } else {
        return Left(AppException.createAndLog('Failed to load businesses: ${response.statusCode}', null, null)); // Server error
      }
    } on DioException catch (e, s) {
      return Left(AppException.createAndLog('Network error: ${e.message}', e, s));
    } catch (e) {
      return Left(AppException.createAndLog('An unexpected error occurred: ${e.toString()}', e, null));
    }
  }
}
