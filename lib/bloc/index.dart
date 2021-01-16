import 'package:flutter/material.dart';


class MainBloc with
    ChangeNotifier,
    ProfileBloc,
    RideHailingBloc,
    ResponseCodesBloc{

  String _bearerToken;
  Address pickUpAddress;
  Address destinationAddress;


  String get bearerToken {
    return _bearerToken;
  }

  set bearerToken(token) {
    _bearerToken = token;
  }

  void updatePickupAddress(Address pickup){
    pickUpAddress = pickup;
    notifyListeners();
  }
  void updateDestinationAddress(Address destination){
    destinationAddress = destination;
    notifyListeners();
  }
}

