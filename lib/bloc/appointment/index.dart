import 'package:flutter/material.dart';
import 'package:hope_clinic/model/date-slots.dart';
import 'package:hope_clinic/model/days-left-count.dart';
import 'package:hope_clinic/model/health-tips.dart';
import 'package:hope_clinic/model/message.dart';
import 'package:hope_clinic/model/next-appointment.dart';
import 'package:hope_clinic/model/plans.dart';
import 'package:hope_clinic/model/upcoming-appointment.dart';
import 'package:hope_clinic/services/appointment/index.dart';

class AppointmentBloc extends ChangeNotifier {
  NextAppointment _nextAppointment;
  DaysLeftCount _daysLeftCount;
  List<Plans> _plans;
  List<HealthTips> _healthTips;
  List<Message> _message;
  List<Dateslots> _dateSlots;
  UpcomingAppointment _upcomingAppointment;
  UpcomingAppointment get upcomingAppointment {
    return _upcomingAppointment;
  }
  set healthTips(List<HealthTips> _data) {
    this._healthTips = _data;
    notifyListeners();
  }
  set dateSlots(List<Dateslots> _data) {
    this._dateSlots = _data;
    notifyListeners();
  }
  set message(List<Message> _data) {
    this._message = _data;
    notifyListeners();
  }
  set plans(List<Plans> _data) {
    this._plans = _data;
    notifyListeners();
  }
  List<HealthTips> get healthTips {
    return _healthTips;
  }

  List<Plans> get plans {
    return _plans;
  }
  List<Dateslots> get dateSlots {
    return _dateSlots;
  }
  List<Message> get message {
    return _message;
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
  ///fetch plans
  Future<List<Plans>> fetchPlans(BuildContext context) async {
    AppointmentService appointmentService = new  AppointmentService(
        context: context);
    List<Plans> _plans = await appointmentService.getPlans();
    this._plans= _plans;
    notifyListeners();
    return _plans;
  }
  ///fetch date slots
  Future<List<Dateslots>> fetchDateSlots(BuildContext context) async {
    AppointmentService appointmentService = new  AppointmentService(
        context: context);
    List<Dateslots> _dateSlots = await appointmentService.getDateSlots();
    print(_dateSlots);
    this._dateSlots= _dateSlots;
    notifyListeners();
    return _dateSlots;
  }
  ///fetch messages
  Future<List<Message>> fetchMessages(BuildContext context) async {
    AppointmentService appointmentService = new  AppointmentService(
        context: context);
    List<Message> _messages = await appointmentService.getUserMessages();
    this._message= _messages;
    notifyListeners();
    return _messages;
  }

}
