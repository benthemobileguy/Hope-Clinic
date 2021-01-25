import 'dart:convert';
import 'package:hope_clinic/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
class PrefManager {
  String auth_token = "auth_token";
  String customerID = "null";
  String isFirstTimeLaunch = "null";

  Future<void> setAuthToken(String auth_token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.auth_token, auth_token);
  }

  Future<String> getAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String auth_token;
    auth_token = pref.getString(this.auth_token) ?? null;
    return auth_token;
  }

  //clear
  Future<void>clearSharedPreferences() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.clear();
  }

  // ///user object
  Future<void> setUserData(Map<String, dynamic> jsonData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = jsonEncode(User.fromJson(jsonData));
    prefs.setString('userData', user);
  }

  Future<User> getUserData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var user;
    if(pref.getString('userData') !=null){
      Map json = jsonDecode(pref.getString('userData'));
      user = User.fromJson(json);
    }
    return user;
  }
}