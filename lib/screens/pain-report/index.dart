import 'package:flutter/material.dart';
import 'package:hope_clinic/screens/components/main-button.dart';
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
        body: SingleChildScrollView(
          child: Column(
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
              Stack(
                  children: [
                Image.asset('images/person_front.png', height: 500, width: 272,),
                    Container(
                      height: 60,
                      child: MainButton(
                        color: primaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new Image.asset('images/icons/bookmark.png',
                              height: 16,
                              width: 10,),
                            SizedBox(
                              width: 14,
                            ),
                            Text(
                              "Next",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Lato',
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        onPressed: null,
                      ),
                    ),
                  ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 60,
                child: MainButton(
                  color: primaryColor,
                  child: Text(
                    "Next",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lato',
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed:null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
