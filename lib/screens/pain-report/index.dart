import 'package:flutter/material.dart';
import 'package:hope_clinic/model/pain-report.dart';
import 'package:hope_clinic/screens/components/main-button.dart';
import 'package:hope_clinic/screens/components/pain-rate-container.dart';
import 'package:hope_clinic/screens/components/pain-selection.dart';
import 'package:hope_clinic/screens/pain-report/pain-report-desc-page.dart';
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
  bool isPainAdded = false;
  String selectedImage = "";
  int painRateIndex = -1;
  List<PainReport> painReportsFront = [];
  List<PainReport> painReportsSide = [];
  List<PainReport> painReportsBack = [];
  List<PainReport> painReportsOtherSide = [];
  StateSetter painModalState;
  List<String> images = [
    "images/person_front.png",
    "images/person_side.png",
    "images/person_back.png",
    "images/person_other_side.png"
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
                    onTapDown: _handleTapDown,
                    child: Container(
                        child: Image.asset(
                      images[index],
                      height: 500,
                      width: double.infinity,
                    )),
                  ),
                     Positioned(
                      top: 0.0,
                       bottom: 0.0,
                       left: 0.0,
                       right: 0.0,
                       child: Stack(
                         children:
                         painReportsFront.asMap().map((i, value) => MapEntry(i,
                           addIndicatorImage
                           (value.offset, value.image),
                         )).values.toList(),
                       ),
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
                            if (index == 3) {
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
                  onPressed: isPainAdded?(){

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context)
                            => PainReportDescPage()));
                  }:null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showPainReportSheet(Offset offset) {
    setState(() {
      painPointIndex=-1;
      painRateIndex=-1;
    });
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter customState /*You can rename this!*/) {
            painModalState = customState;
            painModalState(() {
            });
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
                        onTap: () {
                          painModalState(() {
                            painPointIndex = 0;
                            selectedImage = "images/flash.png";
                          });
                          setState(() {
                            painPointIndex = 0;
                            selectedImage = "images/flash.png";
                          });
                        },
                        child: PainSelection(
                          title: "Sharp Pain",
                          bgColor:
                              painPointIndex != 0 ? Colors.white : primaryColor,
                          textColor:
                              painPointIndex != 0 ? greyColor2 : Colors.white,
                          image: "images/flash.png",
                        ),
                      )),
                      SizedBox(
                        width: 14,
                      ),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          painModalState(() {
                            painPointIndex = 1;
                            selectedImage =  "images/dull.png";
                          });
                          setState(() {
                            painPointIndex = 1;
                            selectedImage =  "images/dull.png";
                          });
                        },
                        child: PainSelection(
                          title: "Dull Pain",
                          image: "images/dull.png",
                          textColor:
                              painPointIndex != 1 ? greyColor2 : Colors.white,
                          bgColor:
                              painPointIndex != 1 ? Colors.white : primaryColor,
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
                        onTap: () {
                          painModalState(() {
                            painPointIndex = 2;
                            selectedImage = "images/knife.png";
                          });
                          setState(() {
                            painPointIndex = 2;
                            selectedImage = "images/knife.png";
                          });
                        },
                        child: PainSelection(
                          title: "Stabbing Pain",
                          textColor:
                              painPointIndex != 2 ? greyColor2 : Colors.white,
                          image: "images/knife.png",
                          bgColor:
                              painPointIndex != 2 ? Colors.white : primaryColor,
                        ),
                      )),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          painModalState(() {
                            painPointIndex = 3;
                            selectedImage = "images/fire.png";
                          });
                          setState(() {
                            painPointIndex = 3;
                            selectedImage = "images/fire.png";
                          });
                        },
                        child: PainSelection(
                          title: "Burning Pain",
                          image: "images/fire.png",
                          textColor:
                              painPointIndex != 3 ? greyColor2 : Colors.white,
                          bgColor:
                              painPointIndex != 3 ? Colors.white : primaryColor,
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
                        onTap: () {
                          painModalState(() {
                            painPointIndex = 4;
                            selectedImage = "images/fire.png";
                          });
                          setState(() {
                            painPointIndex = 4;
                            selectedImage = "images/fire.png";
                          });
                        },
                        child: PainSelection(
                          title: "Tingling",
                          textColor:
                              painPointIndex != 4 ? greyColor2 : Colors.white,
                          image: "images/fire.png",
                          bgColor:
                              painPointIndex != 4 ? Colors.white : primaryColor,
                        ),
                      )),
                      SizedBox(
                        width: 14,
                      ),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          painModalState(() {
                            painPointIndex = 5;
                          });
                          setState(() {
                            painPointIndex = 5;
                          });
                        },
                        child: PainSelection(
                          textColor:
                              painPointIndex != 5 ? greyColor2 : Colors.white,
                          title: "Radiating",
                          image: "images/dull.png",
                          bgColor:
                              painPointIndex != 5 ? Colors.white : primaryColor,
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
                        child: GestureDetector(
                          onTap: () {
                            painModalState(() {
                              painRateIndex = 0;
                            });
                          },
                          child: PainRateContainer(
                            bgColor: HexColor("#C6F47A"),
                            title: "Just\nCurious",
                            emoji: painRateIndex == 0
                                ? Emojis.checkMark
                                : Emojis.neutralFace,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            painModalState(() {
                              painRateIndex = 1;
                            });
                          },
                          child: PainRateContainer(
                            title: "Mild\nPain",
                            bgColor: HexColor("#F9E770"),
                            emoji: painRateIndex == 1
                                ? Emojis.checkMark
                                : Emojis.worriedFace,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            painModalState(() {
                              painRateIndex = 2;
                            });
                          },
                          child: PainRateContainer(
                            bgColor: HexColor("#FAB96F"),
                            title: "Moderate\nPain",
                            emoji: painRateIndex == 2
                                ? Emojis.checkMark
                                : Emojis.sadButRelievedFace,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            painModalState(() {
                              painRateIndex = 3;
                            });
                          },
                          child: PainRateContainer(
                            bgColor: HexColor("#F6877E"),
                            title: "Severe\nPain",
                            emoji: painRateIndex == 3
                                ? Emojis.checkMark
                                : Emojis.perseveringFace,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            painModalState(() {
                              painRateIndex = 4;
                            });
                          },
                          child: PainRateContainer(
                            bgColor: HexColor("#EF5B36"),
                            title: "Worst\nPain",
                            emoji: painRateIndex == 4
                                ? Emojis.checkMark
                                : Emojis.wearyFace,
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
                      onPressed: painPointIndex !=
                          -1 && painRateIndex != -1
                          ? () {
                        setState(() {
                          isPainAdded = true;
                          if(index==0){
                            painReportsFront.add(PainReport(image: selectedImage,
                                offset: offset));
                          }else if(index==1){
                            painReportsSide.add(PainReport(image: selectedImage,
                                offset: offset));
                          }else if(index==2){
                            painReportsOtherSide.add(PainReport(image: selectedImage,
                                offset: offset));
                          }else{
                            painReportsBack.add(PainReport(image: selectedImage,
                                offset: offset));
                          }

                        });
                        Navigator.pop(context);
                      }
                          : null,
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


  void _handleTapDown(TapDownDetails details) {
    final RenderBox referenceBox = context.findRenderObject();
    setState(() {
    Offset _tapPosition = referenceBox.globalToLocal(details.globalPosition);
      print(_tapPosition);
      showPainReportSheet(_tapPosition);

    });
  }

  Widget addIndicatorImage(Offset offset, String image) {
    return  Positioned(
      left: offset.dx-10,
      top: offset.dy - 105,
      child:
      Container(
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
        ),
        child: new Image.asset(image,
          height: 19, width: 19,),
      ),
    );
  }
}
