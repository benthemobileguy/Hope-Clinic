import 'package:flutter/material.dart';


class MainBloc with
    ChangeNotifier{

  String _bearerToken;


  String get bearerToken {
    return _bearerToken;
  }

  set bearerToken(token) {
    _bearerToken = token;
  }

}

