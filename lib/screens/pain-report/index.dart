import 'package:flutter/material.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
class PainReportPage extends StatefulWidget {
  @override
  _PainReportPageState createState() => _PainReportPageState();
}

class _PainReportPageState extends State<PainReportPage> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Touch where you feel the pain",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Lato',
                  color: textColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SvgP
          ],
        ),
      ),
    );
  }
}
