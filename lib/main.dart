import 'package:flutter/material.dart'; //Flutter's core UI components
import 'package:flutter/services.dart'; //Locking orientation
import 'package:flutter_riverpod/flutter_riverpod.dart'; //State management library
import 'package:hive_flutter/hive_flutter.dart'; //Database for Flutter, used for local storage
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'models/board_adapter.dart';

import 'game.dart';

void main() async {
  // Ensuring Flutter is fully initialized before running async tasks
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);

  //Allow only portrait mode on Android & iOS
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  //Make sure Hive is initialized first and only after register the adapter.
  await Hive.initFlutter();
  Hive.registerAdapter(BoardAdapter());

  // Wraps the app with Riverpod's provider scope, allowing global state management
  runApp(const ProviderScope(
    child: MaterialApp(
      title: '2048',
      home: Game(),
    ),
  ));
}
