import 'package:flutter/material.dart';
import 'package:geny_test/core/controller/items_provider.dart';
import 'package:geny_test/feature/business/data/model/business.dart';
import 'package:provider/provider.dart';

class CustomSearchBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: TextField(
          decoration: const InputDecoration(
            hintText: 'Search businesses...',
            filled: true,
            border: InputBorder.none,
          ),
          onChanged: (val) {
            context.read<ItemsNotifier<Business>>().searchByName(val, (b) => b.name);
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
