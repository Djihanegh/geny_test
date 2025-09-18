// business_list_page.dart
import 'package:flutter/material.dart';
import 'package:geny_test/core/controller/items_provider.dart';
import 'package:geny_test/core/ui/widget/item/items_list_view.dart';
import 'package:geny_test/feature/business/data/model/business.dart';
import 'package:geny_test/feature/business/repository/business_repository.dart';
import 'package:geny_test/feature/business/ui/widget/business_card.dart';
import 'package:geny_test/feature/business/ui/widget/search_bar.dart';
import 'package:provider/provider.dart';

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
    debugPrint('Rebuilding Buismess List');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Businesses'),
        bottom: const CustomSearchBar(),
      ),
      body: ItemsListView<Business>(
        padding: 16,
        itemPadding: 16,
        itemBuilder: (context, business) => BusinessCard(business),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<ItemsNotifier<Business>>().updateRating('Glow & Go Salon', 1),
        tooltip: 'Increment',
        child: const Icon(Icons.add), // The plus icon
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Positions the button at the bottom end
    );
  }
}
