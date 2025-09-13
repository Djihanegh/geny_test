import 'package:flutter/material.dart';
import 'package:geny_test/feature/business/data/model/business.dart';
import 'package:go_router/go_router.dart';

class BusinessCard extends StatelessWidget {
  const BusinessCard(this.business, {super.key});

  final Business business;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              height: 300,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.all(Radius.circular(9))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 80, child: Icon(Icons.image_not_supported)),
                  Divider(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " ${business.name}",
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 8),
                      Row(children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.red,
                        ),
                        Text(business.location)
                      ]),
                      const SizedBox(height: 8),
                      Text(' 📞 ${business.phone}'),
                    ],
                  )
                ],
              ),
            )),
        onTap: () => context.push("/business-details", extra: business));
  }
}
