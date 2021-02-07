import 'package:flutter/material.dart';
import 'package:hope_clinic/theme/style.dart';
class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle
          ),
        ),
      ),
    );
  }
}
