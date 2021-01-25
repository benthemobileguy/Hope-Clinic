import 'package:flutter/material.dart';
import 'package:hope_clinic/bloc/index.dart';
import 'package:hope_clinic/services/index.dart';
import 'package:provider/provider.dart';

class AuthenticationService extends ApiService {
  BuildContext context;
  MainBloc bloc;
  AuthenticationService({@required this.context}) : super(context: context);

  Future<Map<String, dynamic>> login
      (String email, String password) async {
  //  PrefManager prefManager = PrefManager();
    bloc = Provider.of<MainBloc>(context);
    Map<String, String> data = new Map();
    data = {
      "username": email,
      "password":password,
    };
    Map<String, dynamic> _response =
    await post('login', data);
    if(_response["responseCode"] == "0"){
      String token = _response["responseBody"]["token"];
      bloc.bearerToken = token;
    //  prefManager.setAuthToken(token);
      print("token" +token);
    }
    return _response;
  }
  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    Map<String, dynamic> _response = await post('signup', data);

    return _response;
  }
  Future<Map<String, dynamic>> fetchUserProfile() async {
    Map<String, dynamic> _response = await get('userDetails');
    return _response;
  }
  Future<Map<String, dynamic>> verifyOTP(Map<String, dynamic> data) async {
    bloc = Provider.of<MainBloc>(context);
    Map<String, dynamic> _response = await post('verifyOTP', data);
    return _response;
  }

}
