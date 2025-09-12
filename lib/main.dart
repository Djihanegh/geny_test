import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:loggy/loggy.dart';
import 'package:path_provider/path_provider.dart';

import 'core/app/geny_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _init();
  runApp(const GenyApp());
}

Future<void> _init() async {
  _initLoggy();
  await _initHive();
}

void _initLoggy() {
  Loggy.initLoggy(
    logOptions: const LogOptions(
      LogLevel.all,
      stackTraceLevel: LogLevel.warning,
    ),
    logPrinter: const PrettyPrinter(),
  );
}

Future<void> _initHive() async {
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
}
