import 'package:flutter/material.dart';
import 'package:geny_test/core/controller/items_provider.dart';
import 'package:provider/provider.dart';

import '../../../controller/items_state.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ItemsListView<T> extends StatelessWidget {
  const ItemsListView({
    required this.itemBuilder,
    super.key,
    this.emptyBuilder,
    this.padding = 8,
    this.itemPadding = 8,
  });

  final ItemWidgetBuilder<T> itemBuilder;
  final WidgetBuilder? emptyBuilder;
  final double padding;
  final double itemPadding;

  @override
  Widget build(BuildContext context) {
    final itemsState = context.watch<ItemsNotifier<T>>().state;
    if (itemsState is ItemsLoading<T>) {
      return const Center(child: CircularProgressIndicator());
    }

    if (itemsState is ItemsError<T>) {
      return Center(child: Text("Error: ${itemsState.message}"));
    }

    if (itemsState is ItemsLoaded<T>) {
      if (itemsState.items.isEmpty) {
        return Center(
          child: emptyBuilder?.call(context) ?? Text("List is empty"),
        );
      }

      return ListView.separated(
        padding: EdgeInsets.all(padding),
        itemCount: itemsState.items.length,
        itemBuilder: (context, index) => itemBuilder(context, itemsState.items[index]),
        separatorBuilder: (context, index) => SizedBox(height: itemPadding),
      );
    }
    return const SizedBox.shrink();
  }
}
