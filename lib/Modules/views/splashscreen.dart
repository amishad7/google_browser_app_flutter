import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen_ extends StatelessWidget {
  const SplashScreen_({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(
        seconds: 2,
      ),
      () {
        Navigator.pushReplacementNamed(context, 'home');
      },
    );

    return Scaffold(
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: NetworkImage(
                  'https://i.pinimg.com/564x/aa/d5/ff/aad5ff98b5af3e7d0e5c8b154c361a9c.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
