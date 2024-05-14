import 'package:flutter/material.dart';

class AppConstants {
  static const Color appColor = Color.fromARGB(255, 166, 139, 60);

  static String query = '';

  static String dynamicApi(String query) {
    return 'https://api.weatherapi.com/v1/current.json?key=5ec803738d1c41499f524700241405&q=$query';
  }
}
