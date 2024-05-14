part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherSuccess extends WeatherState {
  final WeatherModel weatherData;

  WeatherSuccess({required this.weatherData});
}

final class WeatherLoading extends WeatherState {}

final class WeatherFailure extends WeatherState {
  final String message;

  WeatherFailure({required this.message});
}
