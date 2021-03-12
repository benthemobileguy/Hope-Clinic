import 'package:flutter/material.dart';
import 'package:hope_clinic/bloc/index.dart';
import 'package:hope_clinic/model/days-left-count.dart';
import 'package:hope_clinic/model/health-tips.dart';
import 'package:hope_clinic/model/next-appointment.dart';
import 'package:hope_clinic/model/plans.dart';
import 'package:hope_clinic/model/upcoming-appointment.dart';
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
    await get('count/upcoming/appointment');
    print(_data);
    UpcomingAppointment _upcomingAppointment;
    _upcomingAppointment = UpcomingAppointment.fromJson(_data['data']);
    bloc.upcomingAppointment = _upcomingAppointment;
    return _upcomingAppointment;
  }

  /// get next appointment
  Future<NextAppointment> getNextAppointment() async {
    bloc = Provider.of<MainBloc>(context, listen: false);
    Map<String, dynamic> _data =
    await get('count/next/appointment/time');
    print(_data);
    NextAppointment _nextAppointment;
    _nextAppointment = NextAppointment.fromJson(_data['data']);
    bloc.nextAppointment = _nextAppointment;
    return _nextAppointment;
  }

  /// get days left count
  Future<DaysLeftCount> getDaysLeftCount() async {
    bloc = Provider.of<MainBloc>(context, listen: false);
    Map<String, dynamic> _data =
    await get('count/days-left');
    print(_data);
    DaysLeftCount _daysLeftCount;
    _daysLeftCount = DaysLeftCount.fromJson(_data['data']);
    bloc.daysLeftCount = _daysLeftCount;
    return _daysLeftCount;
  }


  /// get health tips
  Future<List<HealthTips>> getHealthTips() async {
    bloc = Provider.of<MainBloc>(context, listen: false);
    Map<String, dynamic> _data =
    await get('health/tip');
    print(_data);
    List<HealthTips> _healthTips = [];
    _healthTips = HealthTips.fromJsonList(_data['health_tips']);
    bloc.healthTips = _healthTips;
    return _healthTips;
  }


  /// get packages
  Future<List<Plans>> getPlans() async {
    bloc = Provider.of<MainBloc>(context, listen: false);
    Map<String, dynamic> _data =
    await get('plan');
    print(_data);
    List<Plans> _plans;
    _plans = Plans.fromJsonList(_data['data']['plans']);
    bloc.plans = _plans;
    return _plans;
  }
  /// get packages
  Future<List<Plans>> getPlans() async {
    bloc = Provider.of<MainBloc>(context, listen: false);
    Map<String, dynamic> _data =
    await get('plan');
    print(_data);
    List<Plans> _plans;
    _plans = Plans.fromJsonList(_data['data']['plans']);
    bloc.plans = _plans;
    return _plans;
  }
}