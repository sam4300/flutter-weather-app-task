import 'package:weather_app_task/constants/global_variables.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_task/models/weather_models.dart';

class WeatherRepository {

  Future<WeatherModel> getWeatherData(String query) async {
    try {
      final res = await http.get(
        Uri.parse(
          AppConstants.dynamicApi(AppConstants.query),
        ),
      );
      return WeatherModel.fromJson(res.body);
    } catch (e) {
      throw Exception(e);
    }
  }
}
