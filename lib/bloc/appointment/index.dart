import 'package:flutter/material.dart';
import 'package:hope_clinic/model/days-left-count.dart';
import 'package:hope_clinic/model/next-appointment.dart';
import 'package:hope_clinic/model/upcoming-appointment.dart';
import 'package:hope_clinic/services/appointment/index.dart';

class AppointmentBloc extends ChangeNotifier {
  NextAppointment _nextAppointment;
  DaysLeftCount _daysLeftCount;
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
}
