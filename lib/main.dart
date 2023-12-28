import 'package:flutter/material.dart';

import 'Modules/views/home.dart';
import 'Modules/views/splashscreen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'intro': (context) => const SplashScreen_(),
        'home': (context) => Mybrowser(),
      },
    ),
  );
}
