import 'package:flutter/material.dart';
class PainReportPage extends StatefulWidget {
  @override
  _PainReportPageState createState() => _PainReportPageState();
}

class _PainReportPageState extends State<PainReportPage> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          "Touch where you feel the pain",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Lato',
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
