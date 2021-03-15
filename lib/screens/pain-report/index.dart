import 'package:flutter/material.dart';
import 'package:hope_clinic/screens/components/main-button.dart';
import 'package:hope_clinic/screens/components/pain-selection.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:hope_clinic/utils/color.dart';
import 'package:mdi/mdi.dart';
import 'package:emojis/emojis.dart'; // to use Emoji collection
import 'package:emojis/emoji.dart'; // to use Emoji utilities

class PainReportPage extends StatefulWidget {
  @override
  _PainReportPageState createState() => _PainReportPageState();
}

class _PainReportPageState extends State<PainReportPage> {
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
                          child: PainSelection(
                        title: "Sharp Pain",
                        image: "images/flash.png",
                      )),
                      SizedBox(
                        width: 14,
                      ),
                      Expanded(
                          child: PainSelection(
                        title: "Dull Pain",
                        image: "images/dull.png",
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: PainSelection(
                        title: "Stabbing Pain",
                        image: "images/knife.png",
                      )),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: PainSelection(
                        title: "Burning Pain",
                        image: "images/fire.png",
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: PainSelection(
                        title: "Tingling",
                        image: "images/fire.png",
                      )),
                      SizedBox(
                        width: 14,
                      ),
                      Expanded(
                          child: PainSelection(
                        title: "Radiating",
                        image: "images/dull.png",
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
                  Column(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        child: Text(
                          Emojis.neutralFace,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Lato',
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: HexColor("#C6F47A"),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            border: Border.all(width: 1)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Just\nCurious",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Lato',
                          color: primaryColor,
                          fontWeight: FontWeight.w400,
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
                ],
              ),
            );
          });
        });
  }
}
