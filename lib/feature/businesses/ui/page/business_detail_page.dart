import 'package:flutter/material.dart';
import 'package:geny_test/feature/businesses/ui/widget/business_card.dart';
import 'package:go_router/go_router.dart';

import '../../data/model/business.dart';

class BusinessDetailsPage extends StatelessWidget {
  final Business business;

  const BusinessDetailsPage({
    super.key,
    required this.business,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(business.name),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(), // Go back to previous page
          )),
      body: Padding(padding: const EdgeInsets.all(16.0), child: BusinessCard(business)),
    );
  }
}
