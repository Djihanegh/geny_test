import 'package:flutter_test/flutter_test.dart';
import 'package:geny_test/core/controller/items_provider.dart';
import 'package:geny_test/core/controller/items_state.dart';
import 'package:geny_test/core/exception/app_exception.dart';
import 'package:geny_test/core/utils/result.dart';
import 'package:geny_test/feature/business/data/model/business.dart';

import '../../feature/business/data/model/business.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('ItemsNotifier', () {
    late ItemsNotifier<Business> notifier;

    setUp(() {
      notifier = ItemsNotifier<Business>();
    });

    test('initial state is ItemsLoading', () {
      expect(notifier.state, isA<ItemsLoading<Business>>());
    });

    test('loadItems success updates state to ItemsLoaded', () async {
      // Arrange
      Future<SuccessResult<List<Business>>> fetcher() async => const SuccessResult<List<Business>>(fakeBusinesses);

      // Act
      await notifier.loadItems(fetcher);

      // Assert
      expect(notifier.state, isA<ItemsLoaded<Business>>());
      final loaded = notifier.state as ItemsLoaded<Business>;
      expect(loaded.items, equals(fakeBusinesses));
    });

    test('loadItems failure updates state to ItemsError', () async {
      // Arrange
      Future<FailureResult<List<Business>>> fetcher() async => const FailureResult<List<Business>>(AppException.noLocalData);

      // Act
      await notifier.loadItems(fetcher);

      // Assert
      expect(notifier.state, isA<ItemsError<Business>>());
      final error = notifier.state as ItemsError<Business>;
      expect(error.message, contains('noLocalData'));
    });
  });
}
