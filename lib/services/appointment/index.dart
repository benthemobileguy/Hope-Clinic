import 'package:flutter/material.dart';
import 'package:hope_clinic/bloc/index.dart';
import 'package:hope_clinic/model/market-shop.dart';
import 'package:hope_clinic/model/next-appointment.dart';
import 'package:hope_clinic/model/reserved-item.dart';
import 'package:hope_clinic/model/upcominng-appointment.dart';
import 'package:hope_clinic/services/index.dart';
import 'package:provider/provider.dart';

class  AppointmentService extends ApiService {
  BuildContext context;
  MainBloc bloc;
  AppointmentService({@required this.context}) : super(context: context);

  /// get upcoming appointment
  Future<UpcomingAppointment> getUpcomingAppointment() async {
    bloc = Provider.of<MainBloc>(context, listen: false);
    Map<String, dynamic> _data =
    await get('store');
    print(_data);
    List<MarketShop> _marketShop = [];
    _marketShop = MarketShop.fromJsonList(_data['data']['store']['data']);
    bloc.marketShop = _marketShop;
    return _marketShop;
  }

  /// get next appointment
  Future<NextAppointment> getNextAppointment() async {
    bloc = Provider.of<MainBloc>(context, listen: false);
    Map<String, dynamic> _data =
    await get('reserve');
    print(_data);
    List<ReservedItem> _reservedItem = [];
    _reservedItem = ReservedItem.fromJsonList(_data['data']['reserves']['data']);
    bloc.reservedItem = _reservedItem;
    return _reservedItem;
  }
}