import 'package:flutter/material.dart';
import 'package:hope_clinic/model/market-shop.dart';
import 'package:hope_clinic/model/next-appointment.dart';
import 'package:hope_clinic/model/reserved-item.dart';
import 'package:hope_clinic/model/upcominng-appointment.dart';
import 'package:hope_clinic/screens/shop/reserved-products-page.dart';
import 'package:hope_clinic/services/shop/index.dart';

class AppointmentBloc extends ChangeNotifier {
  NextAppointment _nextAppointment;
  UpcomingAppointment _upcomingAppointment;
  UpcomingAppointment get upcomingAppointment {
    return _upcomingAppointment;
  }

  set upcomingAppointment(UpcomingAppointment _data) {
    this._upcomingAppointment = _data;
    notifyListeners();
  }

  NextAppointment get nextAppointment {
    return _nextAppointment;
  }

  set reservedItem(NextAppointment _data) {
    this._nextAppointment = _data;
    notifyListeners();
  }

  ///fetch next appointment
  Future<NextAppointment> fetchNextAppointment(BuildContext context) async {
    MarketService marketService = new  MarketService(
        context: context);
    NextAppointment _nextAppointment= await marketService.getMarketShop();
    this._nextAppointment = _nextAppointment;
    notifyListeners();
    return _nextAppointment;
  }
  ///fetch upcoming appointment
  Future<List<ReservedItem>> fetchReservedProducts(BuildContext context) async {
    MarketService marketService = new  MarketService(
        context: context);
    List<ReservedItem> _reservedItems = await marketService.getReservedProducts();
    this._reservedItem = _reservedItems;
    notifyListeners();
    return _reservedItems;
  }
}
