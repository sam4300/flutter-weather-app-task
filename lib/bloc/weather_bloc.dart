import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_task/constants/global_variables.dart';
import 'package:weather_app_task/data/weather_repository.dart';
import 'package:weather_app_task/models/weather_models.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<WeatherDataFetch>((event, emit) async {
      emit(WeatherLoading());
      try {
        final prefs = await SharedPreferences.getInstance();
        final queryFromLocalStorage = prefs.getString('query');
        if (queryFromLocalStorage != null) {
          AppConstants.query = queryFromLocalStorage;
        }

        await Geolocator.checkPermission();
        await Geolocator.requestPermission();

        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        if (AppConstants.query == '') {
          AppConstants.query = extractCoordinates(position);
        }
        final weatherdata = await weatherRepository.getWeatherData(Client());
        emit(WeatherSuccess(weatherData: weatherdata));
      } catch (_) {
        emit(
          WeatherFailure(
            message: 'Sorry cannot fetch data from given location',
          ),
        );
      }
    });
  }
  String extractCoordinates(Position position) {
    final parts = position.toString().split(',');
    final latitudePart = parts[0].substring(parts[0].indexOf(':') + 2).trim();
    final longitudePart = parts[1].substring(parts[1].indexOf(':') + 2).trim();
    return '$latitudePart,$longitudePart';
  }
}
