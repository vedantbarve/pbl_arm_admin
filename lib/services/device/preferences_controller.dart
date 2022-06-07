import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsController {
  Future<String?> getName() async {
    try {
      final pref = await SharedPreferences.getInstance();
      return pref.getString("name");
    } catch (err) {
      debugPrint(err.toString());
    }
    return null;
  }

  Future<String?> getRollNo() async {
    try {
      final pref = await SharedPreferences.getInstance();
      return pref.getString("rollNo");
    } catch (err) {
      debugPrint(err.toString());
    }
    return null;
  }

  Future<String?> getRegNo() async {
    try {
      final pref = await SharedPreferences.getInstance();
      return pref.getString("regNo");
    } catch (err) {
      debugPrint(err.toString());
    }
    return null;
  }

  Future setName(String name) async {
    try {
      final pref = await SharedPreferences.getInstance();
      pref.setString("name", name);
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future setRollNo(String rollNo) async {
    try {
      final pref = await SharedPreferences.getInstance();
      pref.setString("rollNo", rollNo);
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future setRegNo(String regNo) async {
    try {
      final pref = await SharedPreferences.getInstance();
      pref.setString("regNo", regNo);
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
