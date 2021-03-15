import 'package:flutter/material.dart';
import 'package:hope_clinic/screens/components/main-button.dart';
import 'package:hope_clinic/screens/components/pain-rate-container.dart';
import 'package:hope_clinic/screens/components/pain-selection.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:hope_clinic/utils/color.dart';
import 'package:mdi/mdi.dart';
import 'package:emojis/emojis.dart'; // to use Emoji collection

class PainReportPage extends StatefulWidget {
  @override
  _PainReportPageState createState() => _PainReportPageState();
}

class _PainReportPageState extends State<PainReportPage> {
  int painPointIndex = -1;
  int painRateIndex =-1;
  StateSetter painModalState;
  List<String> images = [
    "images/person_front.png",
    "images/person_side.png",
    "images/person_back.png"
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    onTap: () {
                      showPainReportSheet();
                    },
                    child: Container(
                        child: Image.asset(
                      images[index],
                      height: 500,
                      width: double.infinity,
                    )),
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
                            new Image.asset(
                              'images/rotate.png',
                              height: 16,
                              width: 16,
                            ),
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
                        onPressed: () {
                          setState(() {
                            if (index == 2) {
                              index = 0;
                            } else {
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
                  onPressed: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showPainReportSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            painModalState = setState;
            return Container(
              padding: EdgeInsets.all(14),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        "Add Pain Point",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Lato',
                          color: HexColor("#505050"),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          child: new Icon(
                            Mdi.close,
                            color: HexColor("#505050"),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                            onTap: (){
                              painPointIndex = 0;
                            },
                            child: PainSelection(
                        title: "Sharp Pain",
                        bgColor: painPointIndex!=0?Colors.white:primaryColor,
                        image: "images/flash.png",
                      ),
                          )),
                      SizedBox(
                        width: 14,
                      ),
                      Expanded(
                          child: GestureDetector(
                            onTap: (){
                              painPointIndex = 1;
                            },
                            child: PainSelection(
                        title: "Dull Pain",
                        image: "images/dull.png",
                       bgColor: painPointIndex!=1?Colors.white:primaryColor,
                      ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                            onTap: (){
                              painPointIndex = 2;
                            },
                            child: PainSelection(
                        title: "Stabbing Pain",
                        image: "images/knife.png",
                              bgColor: painPointIndex!=2?Colors.white:primaryColor,
                      ),
                          )),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: GestureDetector(
                            onTap: (){
                              painPointIndex = 3;
                            },
                            child: PainSelection(
                        title: "Burning Pain",
                        image: "images/fire.png",
                              bgColor: painPointIndex!=3?Colors.white:primaryColor,
                      ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                            onTap: (){
                              painPointIndex = 4;
                            },
                            child: PainSelection(
                        title: "Tingling",
                        image: "images/fire.png",
                       bgColor: painPointIndex!=4?Colors.white:primaryColor,
                            ),
                          )),
                      SizedBox(
                        width: 14,
                      ),
                      Expanded(
                          child: GestureDetector(
                            onTap: (){
                              painPointIndex = 5;
                            },
                            child: PainSelection(
                        title: "Radiating",
                        image: "images/dull.png",
                              bgColor: painPointIndex!=5?Colors.white:primaryColor,
                      ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Please rate the pain you feel",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lato',
                      color: primaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: PainRateContainer(
                          bgColor: painRateIndex!=0?HexColor("#C6F47A"):primaryColor,
                          title: "Just\nCurious",
                          emoji: Emojis.neutralFace,
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            painModalState(() {
                              painRateIndex = 1;
                            });
                          },
                          child: PainRateContainer(
                            title: "Mild\nPain",
                            bgColor: painRateIndex!=1?HexColor("#F9E770"):primaryColor,
                            emoji: Emojis.worriedFace,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            painModalState(() {
                              painRateIndex = 2;
                            });
                          },
                          child: PainRateContainer(
                            bgColor: painRateIndex!=2?HexColor("#FAB96F"):primaryColor,
                            title: "Moderate\nPain",
                            emoji: Emojis.sadButRelievedFace,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            painModalState(() {
                              painRateIndex = 3;
                            });
                          },
                          child: PainRateContainer(
                            bgColor: painRateIndex!=3?HexColor("#F6877E"):primaryColor,
                            title: "Severe\nPain",
                            emoji: Emojis.perseveringFace,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            painModalState(() {
                              painRateIndex = 4;
                            });
                          },
                          child: PainRateContainer(
                            bgColor: painRateIndex !=4?
                            HexColor("#EF5B36"):primaryColor,
                            title: "Worst\nPain",
                            emoji: Emojis.wearyFace,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 60,
                    child: MainButton(
                      color: primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add Pain",
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
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            );
          });
        });
  }
}
