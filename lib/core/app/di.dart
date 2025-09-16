import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geny_test/core/provider/connectivity_provider.dart';
import 'package:geny_test/feature/business/data/datasources/business_remote_datasource.dart';
import 'package:geny_test/feature/business/repository/business_repository.dart';
import 'package:provider/provider.dart';

import '../../feature/business/data/datasources/business_local_datasource.dart';
import '../../feature/business/data/model/business.dart';
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
        Provider<ConnectivityProvider>(
          create: (_) => ConnectivityProvider(connectivity: Connectivity()),
        ),
        ProxyProvider3<BusinessDioProvider, BusinessHiveBoxProvider, ConnectivityProvider, BusinessRepository>(
          update: (_, remote, local, connectivity, r) => BusinessRepository(remoteProvider: remote, localProvider: local, connectivityProvider: connectivity),
        ),
        ChangeNotifierProvider(create: (_) => ItemsNotifier<Business>())
      ],
      child: child,
    );
  }
}
