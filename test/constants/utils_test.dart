import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('can create preferences', () async {
    SharedPreferences.setMockInitialValues({'query': 'kathmandu'});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('query ', 'kathmandu');

    expect(prefs.getString('query'), 'kathmandu');
  });
}
