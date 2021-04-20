import 'package:flutter/material.dart';
import 'package:hope_clinic/screens/book-appointment/index.dart';
import 'package:hope_clinic/screens/components/main-button.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:hope_clinic/utils/color.dart';
import 'package:mdi/mdi.dart';

class PainReportDescPage extends StatefulWidget {
  @override
  _PainReportDescPageState createState() => _PainReportDescPageState();
}

class _PainReportDescPageState extends State<PainReportDescPage> {
  TextEditingController _controller = TextEditingController();
  bool isDescEntered = false;
  bool isSendingReport = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      if (_controller.text != "") {
        setState(() {
          isDescEntered = true;
        });
      } else {
        setState(() {
          isDescEntered = false;
        });
      }
    });
  }

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
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
            SizedBox(
              height: 20,
            ),
            Container(
              height: 148,
              child: TextField(
                controller: _controller,
                cursorColor: textColor,
                maxLines: 10,
                decoration: InputDecoration(
                    fillColor: containerBgColor,
                    filled: true,
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Lato',
                      color: textColor,
                      fontWeight: FontWeight.w400,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: containerBgColor),
                        borderRadius: BorderRadius.circular(12.0)),
                    hintText: 'Provide extra info for the doctor'),
              ),
            ),
            Spacer(),
            Container(
              height: 60,
              child: MainButton(
                color: primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Send Report",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Lato',
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
                onPressed: isDescEntered
                    ? () {
                        addReport();
                      }
                    : null,
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  void addReport() {
// setState(() {
//   isSendingReport = true;
//   isDescEntered = false;
// });
    showSuccessModal();
  }

  void showSuccessModal() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft:
          Radius.circular(40),
              topRight: Radius.circular(40)),
        ),

        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(

              padding: EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        "Appointment",
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
                    height: 40,
                  ),
                  Text(
                    "Pain Reported",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Lato',
                      color: normalTexth1,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Great, kindly proceed to schedule your appointment",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontFamily: 'Lato',
                      color: HexColor("#999999"),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 60,
                    child: MainButton(
                      color: primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Book An Appointment",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Lato',
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookAppointment()));
                      },
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }
}
