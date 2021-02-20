import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ApiException implements Exception {
  int code;
  String message;
  Map<String, dynamic> errors;
  bool preventRedirect;
  BuildContext context;

  ApiException(
      {this.code,
        this.message,
        this.preventRedirect = false,
        this.errors,
        @required this.context}) {
    switch (code) {
      case 401:
        break;
      case 403:
      // logOut();
        break;
      case 422:
      case 400:
        Fluttertoast.showToast(
          msg: message,
          backgroundColor: Colors.red,
          timeInSecForIosWeb: 2,
          toastLength: Toast.LENGTH_LONG,
        );
        break;
      default:
        Fluttertoast.showToast(msg: message, backgroundColor: Colors.red);
        break;
    }
  }
}

