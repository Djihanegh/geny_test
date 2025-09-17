import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:geny_test/core/app/di.dart';
import 'package:geny_test/core/navigation/router.dart';
import 'package:go_router/go_router.dart';

class GenyApp extends StatelessWidget {
  const GenyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const DI(child: _App());
  }
}

class _App extends StatefulWidget {
  const _App();

  @override
  State<_App> createState() => _AppState();
}

class _AppState extends State<_App> {
  late GoRouter _router;

  @override
  void initState() {
    _router = getRouter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
      child: MaterialApp.router(
        onGenerateTitle: (context) => 'Geny App',
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }
}
