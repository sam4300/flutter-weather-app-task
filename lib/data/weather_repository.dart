import 'package:weather_app_task/constants/global_variables.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_task/models/weather_models.dart';

class WeatherRepository {
  Future<WeatherModel> getWeatherData(http.Client client) async {
    try {
      final res = await client.get(
        Uri.parse(
          'https://api.weatherapi.com/v1/current.json?key=5ec803738d1c41499f524700241405&q=${AppConstants.query}',
        ),
      );
      if (res.statusCode == 200) {
        return WeatherModel.fromJson(res.body);
      }
      throw Exception('Something wnt wrong');
    } catch (e) {
      throw Exception(e);
    }
  }
}
