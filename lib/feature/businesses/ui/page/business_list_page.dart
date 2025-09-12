// business_list_page.dart
import 'package:flutter/material.dart';
import 'package:geny_test/core/controller/items_provider.dart';
import 'package:geny_test/core/ui/widget/item/items_list_view.dart';
import 'package:geny_test/feature/businesses/ui/widget/business_card.dart';
import 'package:provider/provider.dart';

import '../../data/model/business.dart';
import '../../repository/business_repository.dart';

class BusinessListPage extends StatefulWidget {
  const BusinessListPage({super.key});

  @override
  State<BusinessListPage> createState() => _BusinessListPageState();
}

class _BusinessListPageState extends State<BusinessListPage> {
  String query = "";

  @override
  void initState() {
    super.initState();

    context.read<ItemsNotifier<Business>>().loadItems(() => context.read<BusinessRepository>().getAll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Businesses"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search businesses...",
                filled: true,
                border: InputBorder.none,
              ),
              onChanged: (val) {
                context.read<ItemsNotifier<Business>>().searchByName(val, (b) => b.name);
              },
            ),
          ),
        ),
      ),
      body: ItemsListView<Business>(
        padding: 16,
        itemPadding: 16,
        itemBuilder: (context, business) => BusinessCard(business),
      ),
    );
  }
}
