import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:geny_test/core/core.dart';
import 'package:geny_test/core/exception/app_exception.dart';
import 'package:geny_test/core/provider/connectivity_provider.dart';
import 'package:geny_test/core/utils/result.dart';
import 'package:geny_test/feature/business/data/datasources/business_remote_datasource.dart';
import 'package:geny_test/feature/business/data/model/business.dart';

class BusinessRepository extends ItemRepository<Business> {
  BusinessRepository({
    required this.remoteProvider,
    required this.localProvider,
    required this.connectivityProvider,
  });

  final BusinessDioProvider remoteProvider;
  final HiveBoxProvider<Business> localProvider;
  final ConnectivityProvider connectivityProvider;

  @override
  Future<Either<AppException, List<Business>>> getAll() async {
    final connectivityResult = await connectivityProvider.checkConnectivity();

    if (connectivityResult.isNotEmpty && !connectivityResult.contains(ConnectivityResult.none)) {
      try {
        // Get data from API
        final remoteData = await remoteProvider.getAll();

        return await remoteData.fold(
          // left: error
          (e) async {
            return getCachedData(e, null);
          },
          // right: success
          (r) async {
            await localProvider.saveAll(
              r,
              keyBuilder: (b) => b.name,
              toJson: (b) => b.toJson(),
            );
            return Right(r);
          },
        ); //

        // Store in Hive
      } catch (e, s) {
        // Fallback to local data on network error
        return getCachedData(e, s);
      }
    } else {
      // Return local data when offline
      return getCachedData(null, null);
    }
  }

  Future<Result<List<Business>>> getCachedData(dynamic e, StackTrace? s) async {
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
