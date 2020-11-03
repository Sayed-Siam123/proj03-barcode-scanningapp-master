import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {

//set data into shared preferences like this
  Future<void> setData(String key,String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<void> setData_int(String key,int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

//get value from shared preferences
  Future<String> getData(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String data;
    data = pref.getString(key) ?? null;
    return data;
  }

  Future<bool> getBoolData(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    bool data;
    data = pref.getBool(key) ?? null;
    return data;
  }


  Future<void> removeData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }


  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

}