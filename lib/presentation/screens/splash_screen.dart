import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app_task/constants/global_variables.dart';
import 'package:weather_app_task/presentation/screens/homepage_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool isNavigated = false;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.forward();

    showDelayedScreen();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    controller.removeListener(() {});
    super.dispose();
  }

  void showDelayedScreen() {
    if (isNavigated) return;

    Future.delayed(const Duration(seconds: 5)).then((value) {
      if (mounted && !isNavigated) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePageScreen(),
          ),
        );
      }
    });

    isNavigated = false;
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
              color: AppConstants.appColor,
              value: controller.value,
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePageScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppConstants.appColor,
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
