import 'package:flutter/material.dart';
import 'package:hope_clinic/model/days-left-count.dart';
import 'package:hope_clinic/model/health-tips.dart';
import 'package:hope_clinic/model/next-appointment.dart';
import 'package:hope_clinic/model/packages.dart';
import 'package:hope_clinic/model/upcoming-appointment.dart';
import 'package:hope_clinic/services/appointment/index.dart';

class AppointmentBloc extends ChangeNotifier {
  NextAppointment _nextAppointment;
  DaysLeftCount _daysLeftCount;
  Packages _packages;
  List<HealthTips> _healthTips;
  UpcomingAppointment _upcomingAppointment;
  UpcomingAppointment get upcomingAppointment {
    return _upcomingAppointment;
  }
  set healthTips(List<HealthTips> _data) {
    this._healthTips = _data;
    notifyListeners();
  }

  List<HealthTips> get healthTips {
    return _healthTips;
  }
  set packages(Packages _data) {
    this._packages = _data;
    notifyListeners();
  }

  Packages get packages {
    return _packages;
  }
  set upcomingAppointment(UpcomingAppointment _data) {
    this._upcomingAppointment = _data;
    notifyListeners();
  }

  NextAppointment get nextAppointment {
    return _nextAppointment;
  }

  set nextAppointment(NextAppointment _data) {
    this._nextAppointment = _data;
    notifyListeners();
  }
  DaysLeftCount get daysLeftCount {
    return _daysLeftCount;
  }

  set daysLeftCount(DaysLeftCount _data) {
    this._daysLeftCount = _data;
    notifyListeners();
  }
  ///fetch next appointment
  Future<NextAppointment> fetchNextAppointment(BuildContext context) async {
    AppointmentService appointmentService = new AppointmentService(
        context: context);
    NextAppointment _nextAppointment= await appointmentService.getNextAppointment();
    this._nextAppointment = _nextAppointment;
    notifyListeners();
    return _nextAppointment;
  }
  ///fetch upcoming appointment
  Future<UpcomingAppointment> fetchUpcomingAppointment(BuildContext context) async {
    AppointmentService appointmentService = new  AppointmentService(
        context: context);
    UpcomingAppointment _upcomingAppointment = await appointmentService.getUpcomingAppointment();
    this._upcomingAppointment = _upcomingAppointment;
    notifyListeners();
    return _upcomingAppointment;
  }
  ///fetch days left count
  Future<DaysLeftCount> fetchDaysLeftCount(BuildContext context) async {
    AppointmentService appointmentService = new  AppointmentService(
        context: context);
    DaysLeftCount _daysLeftCount= await appointmentService.getDaysLeftCount();
    this._daysLeftCount = _daysLeftCount;
    notifyListeners();
    return _daysLeftCount;
  }
  ///fetch health Tips
  Future<List<HealthTips>> fetchHealthTips(BuildContext context) async {
    AppointmentService appointmentService = new  AppointmentService(
        context: context);
    List<HealthTips> _healthTips= await appointmentService.getHealthTips();
    this._healthTips= _healthTips;
    notifyListeners();
    return _healthTips;
  }
  ///fetch packages
  Future<Packages> fetchPakages(BuildContext context) async {
    AppointmentService appointmentService = new  AppointmentService(
        context: context);
    Packages _packages= await appointmentService.getPackages();
    this._packages = _packages;
    notifyListeners();
    return _packages;
  }
}
