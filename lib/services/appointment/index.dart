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
    UpcomingAppointment _upcomingAppointment;
    _upcomingAppointment = UpcomingAppointment.fromJson(_data);
    bloc._upcomingAppointment;
    return _upcomingAppointment;
  }

  /// get next appointment
  Future<NextAppointment> getNextAppointment() async {
    bloc = Provider.of<MainBloc>(context, listen: false);
    Map<String, dynamic> _data =
    await get('reserve');
    print(_data);
    NextAppointment _nextAppointment;
    _nextAppointment = NextAppointment.fromJson(_data['data']);
    bloc.reservedItem = _reservedItem;
    return _nextAppointment;
  }
}