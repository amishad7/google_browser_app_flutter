import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen_ extends StatelessWidget {
  const SplashScreen_({super.key});

  @override
  Widget build(BuildContext context) {

    Timer(Duration( seconds: 2,), () { });

    return const Scaffold(
      body: Center(child: ColoredBox(color: Colors.red)),
    );
  }
}
