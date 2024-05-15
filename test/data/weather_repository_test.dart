import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app_task/constants/global_variables.dart';
import 'package:weather_app_task/data/weather_repository.dart';
import 'package:weather_app_task/models/weather_models.dart';

class MockHTTPClient extends Mock implements Client {}

void main() {
  late WeatherRepository weatherRepository;
  late MockHTTPClient mockHTTPClient;
  setUp(() {
    weatherRepository = WeatherRepository();
    mockHTTPClient = MockHTTPClient();
  });
  group(
    'getWeatherData function',
    () {
      test(
        'given WeatherRepository class when getWeatherData fucntion is called and status code is 200 then a weathermodel should be returned',
        () async {
          when(
            () => mockHTTPClient.get(
              Uri.parse(
                'https://api.weatherapi.com/v1/current.json?key=5ec803738d1c41499f524700241405&q=${AppConstants.query}',
              ),
            ),
          ).thenAnswer((invocation) async {
            return Response("""
                {
                  "location": {
                      "name": "Glen Query",
                      "region": "Maryland",
                      "country": "United States of America",
                      "lat": 39.07,
                      "lon": -77.28
                  },
                  "current": {
                      "temp_c": 16.1,
                      "condition": {
                          "text": "Sunny",
                          "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                          "code": 1000
                      }
                  }
              }""", 200);
          });
          final weatherData =
              await weatherRepository.getWeatherData(mockHTTPClient);

          expect(weatherData, isA<WeatherModel>());
        },
      );

      test(
        'given WeatherRepository class when getWeatherData fucntion is called and status code is not 200 then an exception should be thrown',
        () async {
          when(
            () => mockHTTPClient.get(
              Uri.parse(
                'https://api.weatherapi.com/v1/current.json?key=5ec803738d1c41499f524700241405&q=${AppConstants.query}',
              ),
            ),
          ).thenAnswer(
            (invocation) async {
              return Response('{}', 500);
            },
          );
          final weatherData = weatherRepository.getWeatherData(mockHTTPClient);
          expect(weatherData, throwsException);
        },
      );
    },
  );
}
