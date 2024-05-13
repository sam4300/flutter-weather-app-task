import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app_task/presentation/screens/homepage_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;
  Timer? _timer;
  bool isNavigated = false;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(milliseconds: 100),
      (_) {
        if (mounted) {
          setState(() {
            _progress += 0.02;
            if (_progress >= 1.0) {
              _timer?.cancel();
            }
          });
        }
      },
    );

    showDelayedScreen();
  }

  Future<void> showDelayedScreen() async {
    await Future.delayed(const Duration(seconds: 5));
    if (mounted && !isNavigated) {
      Navigator.pushAndRemoveUntil(
          context, HomePageScreen.route, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Image.asset(
          'assets/images/weather_app_frame.png',
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        Positioned(
          top: 10,
          child: SizedBox(
            width: size.width,
            child: LinearProgressIndicator(
              color: const Color.fromARGB(255, 166, 139, 60),
              value: _progress,
            ),
          ),
        ),
        Positioned(
          top: size.height / 3.7,
          width: size.width / 1.2,
          child: const Text(
            textAlign: TextAlign.center,
            'We Show Weather For You',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 166, 139, 60),
              fontSize: 25,
            ),
          ),
        ),
        Positioned(
          bottom: size.height / 5,
          child: Row(
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size(size.width / 2, 50),
                ),
                onPressed: () {
                  setState(() {
                    isNavigated = true;
                  });
                  Navigator.pushAndRemoveUntil(
                      context, HomePageScreen.route, (route) => false);
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 166, 139, 60),
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
