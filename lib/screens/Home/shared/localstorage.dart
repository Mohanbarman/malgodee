import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static loadData({String id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (exists(id: id)) return prefs.get(id);
    return null;
  }

  static saveData({dynamic model}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(model.id, json.encode(model.toJson()));
  }

  static exists({String id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(id);
  }
}
