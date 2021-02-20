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
    Fluttertoast.showToast(msg: message, backgroundColor: Colors.red);
  }
}

