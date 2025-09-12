import 'package:flutter/material.dart';
import 'package:geny_test/feature/businesses/data/model/business.dart';

class BusinessCard extends StatelessWidget {
  const BusinessCard(this.business, {super.key});

  final Business business;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Container(
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
                    business.name,
                    textAlign: TextAlign.start,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      Text(business.location)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.grey,
                      ),
                      Text(business.phone)
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}
