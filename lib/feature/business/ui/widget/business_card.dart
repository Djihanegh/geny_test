import 'package:flutter/material.dart';
import 'package:geny_test/core/controller/items_provider.dart';
import 'package:geny_test/core/logger/logger.dart';
import 'package:geny_test/core/logger/loggy_types.dart';
import 'package:geny_test/feature/business/data/model/business.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BusinessCard extends StatelessWidget with UiLoggy {
  const BusinessCard(this.business, {super.key});

  final Business business;

  @override
  Widget build(BuildContext context) {
    logInfo('Rebuilding Business Card Widget');
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 300,
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.all(Radius.circular(9))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80, child: Icon(Icons.image_not_supported)),
              const Divider(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' ${business.name}',
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.red,
                      ),
                      Text(business.location),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(' 📞 ${business.phone}'),
                  const SizedBox(
                    height: 8,
                  ),
                  Selector<ItemsNotifier<Business>, double>(
                    selector: (_, provider) => provider.getRating(business.name),
                    builder: (_, rating, __) {
                      return Text('⭐ Rating: $rating');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () => context.push('/business-details', extra: business),
    );
  }
}
