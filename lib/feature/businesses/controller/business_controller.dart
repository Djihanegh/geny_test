import 'package:flutter/material.dart';

import '../data/model/business.dart';
import '../repository/business_repository.dart';

class BusinessController extends ChangeNotifier {
  final BusinessRepository _repository;

  BusinessController(this._repository);

  List<Business> _businesses = [];
  bool _isLoading = false;
  String? _error;

  List<Business> get businesses => _businesses;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadBusinesses() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _repository.getAll();
    result.fold(
      (failure) => _error = failure.getText(),
      (data) => _businesses = data,
    );

    _isLoading = false;
    notifyListeners();
  }
}
