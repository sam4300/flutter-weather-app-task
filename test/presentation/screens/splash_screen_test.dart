import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_task/bloc/weather_bloc.dart';
import 'package:weather_app_task/data/weather_repository.dart';
import 'package:weather_app_task/presentation/screens/splash_screen.dart';

void main() {
  testWidgets(
      'given splash screen when page is built then a text and button should be displayed',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      RepositoryProvider(
        create: (context) => WeatherRepository(),
        child: BlocProvider(
          create: (context) => WeatherBloc(context.read<WeatherRepository>()),
          child: const MaterialApp(
            home: SplashScreen(),
          ),
        ),
      ),
    );

    await tester.pump(const Duration(seconds: 5));

    final textFinder = find.text('We Show Weather For You');
    expect(textFinder, findsOneWidget);

    final buttonFinder = find.byType(TextButton);
    expect(buttonFinder, findsOneWidget);
  });
}
