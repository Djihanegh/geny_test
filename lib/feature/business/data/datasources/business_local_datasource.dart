import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geny_test/core/core.dart';
import 'package:geny_test/feature/business/data/model/business.dart';

class BusinessHiveBoxProvider extends HiveBoxProvider<Business> {
  BusinessHiveBoxProvider()
      : super(
          boxName: HiveBoxName.businesses,
          fromJson: Business.fromJson,
          toJson: (business) => business.toJson(),
        );

  @override
  Future<List<Business>> getAll() async {
    if (await isEmpty) {
      await _addDummyBusinesses();
    }

    return super.getAll();
  }

  Future<void> _addDummyBusinesses() async {
    try {
      final data = await rootBundle.loadString('assets/data/businesses.json');
      final parsed = jsonDecode(data) as List<Map<String, dynamic>>;

      for (final e in parsed) {
        await add(Business.fromJson(e));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
