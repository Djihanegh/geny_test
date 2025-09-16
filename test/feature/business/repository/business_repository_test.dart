import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geny_test/core/core.dart';
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

  group("BusinessRepository.getAll", () {
    test("returns [Business] when online (cached data)", () async {
      // Arrange
      when(() => connectivity.checkConnectivity()).thenAnswer((_) async => [ConnectivityResult.wifi]);

      when(() => remoteProvider.getAll()).thenAnswer((_) async => Future.value({}));

      when(() => localProvider.saveAll(any(), keyBuilder: any(named: "keyBuilder"), toJson: any(named: "toJson"))).thenAnswer((_) async => Future.value());

      when(() => localProvider.getAll()).thenAnswer((_) async => fakeBusinesses);

      // Act
      final result = await repository.getAll();

      print(result.toString());

      // Assert
      expect(result.isRight(), true);

      result.fold((_) => fail('Should return businesses'), (list) {
        expect(list.length, 3);
        expect(list.first.name, "Glow & Go Salon");
      });

      verify(() => remoteProvider.getAll()).called(1);
      verifyNever(() => localProvider.saveAll(any(), keyBuilder: any(named: "keyBuilder"), toJson: any(named: "toJson")));
    });

    test("returns [Business] when offline (cached data)", () async {
      // Arrange
      when(() => connectivity.checkConnectivity()).thenAnswer((_) async => [ConnectivityResult.none]);

      when(() => remoteProvider.getAll()).thenAnswer((_) async => Future.value({}));

      when(() => localProvider.saveAll(any(), keyBuilder: any(named: "keyBuilder"), toJson: any(named: "toJson"))).thenAnswer((_) async => Future.value());

      when(() => localProvider.getAll()).thenAnswer((_) async => fakeBusinesses);

      // Act
      final result = await repository.getAll();

      print(result.toString());

      // Assert
      expect(result.isRight(), true);

      result.fold((_) => fail('Should return businesses'), (list) {
        expect(list.length, 3);
        expect(list.first.name, "Glow & Go Salon");
      });

      verifyNever(() => remoteProvider.getAll());
      verifyNever(() => localProvider.saveAll(any(), keyBuilder: any(named: "keyBuilder"), toJson: any(named: "toJson")));
    });
  });
}
