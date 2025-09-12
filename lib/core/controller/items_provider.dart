import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../exception/app_exception.dart';
import 'items_state.dart';

class ItemsNotifier<T> extends ChangeNotifier {
  ItemsState<T> _state = ItemsLoading<T>();
  ItemsState<T> get state => _state;

  List<T> _allItems = [];

  Future<void> loadItems(Future<Either<AppException, List<T>>> Function() fetcher) async {
    _state = ItemsLoading<T>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    final items = await fetcher();

    items.fold((failure) => _state = ItemsError<T>(failure.toString()), (data) {
      _allItems = data;
      _state = ItemsLoaded<T>(data);
    });

    notifyListeners();
  }

  void searchByName(String query, String Function(T) getName) {
    if (_allItems.isEmpty) return;

    if (query.isEmpty) {
      _state = ItemsLoaded<T>(_allItems);
    } else {
      final filtered = _allItems.where((item) => getName(item).toLowerCase().contains(query.toLowerCase())).toList();

      _state = ItemsLoaded<T>(filtered);
    }

    notifyListeners();
  }
}
