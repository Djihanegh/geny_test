// business_list_page.dart
import 'package:flutter/material.dart';
import 'package:geny_test/core/controller/items_provider.dart';
import 'package:geny_test/core/ui/widget/item/items_list_view.dart';
import 'package:geny_test/feature/businesses/ui/widget/business_card.dart';
import 'package:provider/provider.dart';

import '../../data/model/business.dart';
import '../../repository/business_repository.dart';
import '../widget/search_bar.dart';

class BusinessListPage extends StatefulWidget {
  const BusinessListPage({super.key});

  @override
  State<BusinessListPage> createState() => _BusinessListPageState();
}

class _BusinessListPageState extends State<BusinessListPage> {
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
        bottom: CustomSearchBar(),
      ),
      body: ItemsListView<Business>(
        padding: 16,
        itemPadding: 16,
        itemBuilder: (context, business) => BusinessCard(business),
      ),
    );
  }
}
