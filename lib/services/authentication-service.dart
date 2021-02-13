import 'package:flutter/material.dart';
import 'package:hope_clinic/bloc/index.dart';
import 'package:hope_clinic/services/index.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:hope_clinic/utils/color.dart';
import 'package:hope_clinic/utils/pref-manager.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthenticationService extends ApiService {
  BuildContext context;
  MainBloc bloc;
  AuthenticationService({@required this.context}) : super(context: context);

  Future<Map<String, dynamic>> login
      (String email, String password) async {
  PrefManager prefManager = PrefManager();
    bloc = Provider.of<MainBloc>(context);
    Map<String, String> data = new Map();
    data = {
      "email": email,
      "password":password,
    };
    Map<String, dynamic> _response =
    await post('login', data);
    if(_response["status"] == true){
      String token = _response["token"];
      bloc.bearerToken = token;
      prefManager.setAuthToken(token);
      prefManager.setUserData(_response['user']);
      print("token" +token);
    }
    return _response;
  }
  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    Map<String, dynamic> _response = await post('register', data);

    return _response;
  }
  Future<Map<String, dynamic>> editProfile
      (Map<String, dynamic> data) async {
    Map<String, dynamic> _response = await post('user/update', data);

    return _response;
  }
  Future<Map<String, dynamic>> fetchUserProfile() async {
    Map<String, dynamic> _response = await get('userDetails');
    return _response;
  }
  Future<Map<String, dynamic>> verifyOTP(Map<String, dynamic> data) async {
    bloc = Provider.of<MainBloc>(context);
    Map<String, dynamic> _response = await post('verify-account', data);
    return _response;
  }

}
