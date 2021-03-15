import 'package:flutter/material.dart';
import 'package:hope_clinic/theme/style.dart';
class PainReportDescPage extends StatefulWidget {
  @override
  _PainReportDescPageState createState() => _PainReportDescPageState();
}

class _PainReportDescPageState extends State<PainReportDescPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Pain Report",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Lato',
            color: textColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 30,
          ),
          color: textColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Text(
            "Extra Information",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Lato',
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
