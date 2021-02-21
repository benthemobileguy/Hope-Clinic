import 'package:flutter/material.dart';
import 'package:hope_clinic/bloc/appointment/index.dart';
import 'package:hope_clinic/bloc/shop/index.dart';
import 'package:hope_clinic/model/health-tips.dart';
import 'package:hope_clinic/model/user.dart';

class MainBloc with ChangeNotifier,
    ShopBloc, AppointmentBloc{

  String _bearerToken;
  User _user;
  HealthTips _healthTips;

  String get bearerToken {
    return _bearerToken;
  }

  User get user {
    return _user;
  }

  set bearerToken(token) {
    _bearerToken = token;
  }

  set user(User _data) {
    this._user = _data;
    notifyListeners();
  }
}
