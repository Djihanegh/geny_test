import '../../../../core/core.dart';
import '../model/business.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

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
    final data = await rootBundle.loadString("assets/data/businesses.json");
    final List<dynamic> parsed = jsonDecode(data);
    parsed.map((e) async => await add(Business.fromJson(e)));
  }
}
