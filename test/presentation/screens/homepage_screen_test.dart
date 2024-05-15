import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app_task/bloc/weather_bloc.dart';
import 'package:weather_app_task/data/weather_repository.dart';
import 'package:weather_app_task/presentation/screens/homepage_screen.dart';

void main() {
  testWidgets('home screen loads properly', (tester) async {
//find components
    final locationField = find.byType(TextField);
    final button = find.byType(ElevatedButton);

    await tester.pumpWidget(
      RepositoryProvider(
        create: (context) => WeatherRepository(),
        child: BlocProvider(
          create: (context) => WeatherBloc(context.read<WeatherRepository>()),
          child: const MaterialApp(
            home: HomePageScreen(),
          ),
        ),
      ),
    );

    await tester.enterText(locationField, 'london');
    await tester.tap(button);
    await tester.pump();

    //checking outputs
    expect(find.text('london'), findsOneWidget);

//testing if all he ui components loads properly
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(locationField, findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
    expect(button, findsOneWidget);
  });
}
