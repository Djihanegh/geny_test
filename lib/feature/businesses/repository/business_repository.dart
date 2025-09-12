import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:geny_test/core/exception/app_exception.dart';
import 'package:geny_test/feature/businesses/data/datasources/business_remote_datasource.dart';
import 'package:geny_test/feature/businesses/data/model/business.dart';

import '../../../core/core.dart';

class BusinessRepository extends ItemRepository<Business> {
  BusinessRepository({
    required this.remoteProvider,
    required this.localProvider,
  });

  final BusinessDioProvider remoteProvider;
  final HiveBoxProvider<Business> localProvider;

  @override
  Future<Either<AppException, List<Business>>> getAll() async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult.isNotEmpty && !connectivityResult.contains(ConnectivityResult.none)) {
      try {
        // Get data from API
        final remoteData = await remoteProvider.getAll();
        final businesses = (remoteData as List).map((e) => Business.fromJson(e)).toList();

        // Store in Hive
        await localProvider.saveAll(
          businesses,
          keyBuilder: (b) => b.name,
          toJson: (b) => b.toJson(),
        );

        return Right(businesses);
      } catch (e, s) {
        // Fallback to local data on network error
        return await getCachedData(e, s);
      }
    } else {
      // Return local data when offline
      return await getCachedData(null, null);
    }
  }

  Future<Either<AppException, List<Business>>> getCachedData(dynamic e, StackTrace? s) async {
    final cachedData = await localProvider.getAll();

    if (cachedData.isNotEmpty) {
      return Right(cachedData);
    } else {
      final exception = AppException.createAndLog(
        'noLocalData',
        e,
        s,
      );
      return Left(exception);
    }
  }
}
