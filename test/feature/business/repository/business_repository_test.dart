import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geny_test/core/core.dart';
import 'package:geny_test/core/exception/app_exception.dart';
import 'package:geny_test/core/provider/connectivity_provider.dart';
import 'package:geny_test/feature/business/data/datasources/business_remote_datasource.dart';
import 'package:geny_test/feature/business/data/model/business.dart';
import 'package:geny_test/feature/business/repository/business_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../data/model/business.dart';

// MOCKS //
class MockBusinessDioProvider extends Mock implements BusinessDioProvider {}

class MockHiveBoxProvider extends Mock implements HiveBoxProvider<Business> {}

class MockConnectivity extends Mock implements ConnectivityProvider {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late BusinessRepository repository;
  late MockBusinessDioProvider remoteProvider;
  late MockHiveBoxProvider localProvider;
  late MockConnectivity connectivity;

  setUp(() {
    remoteProvider = MockBusinessDioProvider();
    localProvider = MockHiveBoxProvider();
    connectivity = MockConnectivity();

    repository = BusinessRepository(
      remoteProvider: remoteProvider,
      localProvider: localProvider,
      connectivityProvider: connectivity,
    );
  });

  group('BusinessRepository.getAll', () {
    test('returns Right(CachedData) when online && cache is not empty', () async {
      // Arrange
      when(() => connectivity.checkConnectivity()).thenAnswer((_) async => [ConnectivityResult.wifi]);

      when(() => remoteProvider.getAll()).thenAnswer((_) async => const Right(fakeBusinesses));

      when(() => localProvider.saveAll(any(), keyBuilder: any(named: 'keyBuilder'), toJson: any(named: 'toJson'))).thenAnswer((_) async => Future.value());

      when(() => localProvider.getAll()).thenAnswer((_) async => fakeBusinesses);

      // Act
      final result = await repository.getAll();

      // Assert
      expect(result.isRight(), true);

      result.fold((_) => fail('Should return businesses'), (list) {
        expect(list.length, 3);
        expect(list.first.name, 'Glow & Go Salon');
      });

      verify(() => remoteProvider.getAll()).called(1);
      // verifyNever(() => localProvider.saveAll(any(), keyBuilder: any(named: 'keyBuilder'), toJson: any(named: 'toJson')));
    });

    test('returns Right(cachedData) when offline  && cache is not empty', () async {
      // Arrange
      when(() => connectivity.checkConnectivity()).thenAnswer((_) async => [ConnectivityResult.none]);

      when(() => remoteProvider.getAll()).thenAnswer((_) async => const Right(<Business>[]));

      when(() => localProvider.saveAll(any(), keyBuilder: any(named: 'keyBuilder'), toJson: any(named: 'toJson'))).thenAnswer((_) async => Future.value());

      when(() => localProvider.getAll()).thenAnswer((_) async => fakeBusinesses);

      // Act
      final result = await repository.getAll();

      // Assert
      expect(result.isRight(), true);

      result.fold((_) => fail('Should return businesses'), (list) {
        expect(list.length, 3);
        expect(list.first.name, 'Glow & Go Salon');
      });

      verifyNever(() => remoteProvider.getAll());
      verifyNever(() => localProvider.saveAll(any(), keyBuilder: any(named: 'keyBuilder'), toJson: any(named: 'toJson')));
    });

    test('returns AppException when cache is empty ( Online ) ', () async {
      // Arrange
      when(() => connectivity.checkConnectivity()).thenAnswer((_) async => [ConnectivityResult.wifi]);

      when(() => remoteProvider.getAll()).thenAnswer((_) async => const Left(AppException.unknown));

      when(() => localProvider.getAll()).thenAnswer((_) async => []);

      // Act
      final result = await repository.getAll();

      // Assert
      expect(result.isLeft(), true);

      result.fold((error) {
        expect(error, isA<AppException>());
        expect(error.getText(), 'Unknown error occurred');
      }, (_) {
        fail('Should have returned an AppException ( Left )');
      });

      verify(() => remoteProvider.getAll()).called(1);
      verifyNever(() => localProvider.saveAll(any(), keyBuilder: any(named: 'keyBuilder'), toJson: any(named: 'toJson')));
    });
  });
}
