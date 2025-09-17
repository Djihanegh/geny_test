import 'package:flutter/material.dart';
import 'package:geny_test/feature/business/data/model/business.dart';
import 'package:geny_test/feature/business/ui/widget/business_card.dart';
import 'package:go_router/go_router.dart';

class BusinessDetailsPage extends StatelessWidget {
  const BusinessDetailsPage({
    required this.business,
    super.key,
  });
  final Business business;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(business.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(), // Go back to previous page
        ),
      ),
      body: Padding(padding: const EdgeInsets.all(16), child: BusinessCard(business)),
    );
  }
}
