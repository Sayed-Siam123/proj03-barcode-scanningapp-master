import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {

//set data into shared preferences like this
  Future<void> setAuthToken(String key,String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

//get value from shared preferences
  Future<String> getAuthToken(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String data;
    data = pref.getString(key) ?? null;
    return data;
  }
}