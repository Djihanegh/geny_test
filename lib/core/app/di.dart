import 'package:flutter/material.dart';
import 'package:geny_test/feature/businesses/data/datasources/business_remote_datasource.dart';
import 'package:geny_test/feature/businesses/repository/business_repository.dart';
import 'package:provider/provider.dart';

import '../../feature/businesses/data/datasources/business_local_datasource.dart';
import '../../feature/businesses/data/model/business.dart';
import '../controller/items_provider.dart';

class DI extends StatelessWidget {
  const DI({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _ProviderDI(
      child: child,
    );
  }
}

class _ProviderDI extends StatelessWidget {
  const _ProviderDI({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<BusinessDioProvider>(
          create: (_) => BusinessDioProvider(),
        ),
        Provider<BusinessHiveBoxProvider>(
          create: (_) => BusinessHiveBoxProvider(),
        ),
        ProxyProvider2<BusinessDioProvider, BusinessHiveBoxProvider, BusinessRepository>(
          update: (_, remote, local, __) => BusinessRepository(
            remoteProvider: remote,
            localProvider: local,
          ),
        ),
        ChangeNotifierProvider(create: (_) => ItemsNotifier<Business>())
      ],
      child: child,
    );
  }
}
