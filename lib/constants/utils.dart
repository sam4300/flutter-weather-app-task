import 'package:shared_preferences/shared_preferences.dart';

Future<void> addToLocalStorage(SharedPreferences prefs, String text) async {
  prefs.setString('query', text);
}
