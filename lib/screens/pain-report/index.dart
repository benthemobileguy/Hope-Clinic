import 'package:flutter/material.dart';
import 'package:hope_clinic/screens/components/main-button.dart';
import 'package:hope_clinic/theme/style.dart';

class PainReportPage extends StatefulWidget {
  @override
  _PainReportPageState createState() => _PainReportPageState();
}

class _PainReportPageState extends State<PainReportPage> {
  List<String> images = ["images/person_front.png", "images/person_side.png", "images/person_back.png"];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
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
                GestureDetector(
                  onTap: (){

                  },

                  child: Container(child:
                  Image.asset(images[index],
                    height: 500, width: double.infinity,)),
                ),
                    Positioned(
                      right: 20.0,
                      bottom: 70.0,
                      child: Container(
                        width: 100,
                        height: 48,
                        child: MainButton(
                          color: primaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              new Image.asset('images/rotate.png',
                                height: 16,
                                width: 16,),
                              SizedBox(
                                width: 14,
                              ),
                              Text(
                                "Turn",
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
                          onPressed: (){
                           setState(() {
                             if(index==2){
                               index = 0;
                             }else{
                               index++;
                             }
                           });
                          },
                        ),
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
