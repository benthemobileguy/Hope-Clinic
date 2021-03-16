import 'package:flutter/material.dart';
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
    _controller.addListener((){
     if(_controller.text!=""){
       setState(() {
       isDescEntered = true;
       });
     }else{
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
                   !isSendingReport ?Text(
                      "Send Report",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Lato',
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ):SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                  new AlwaysStoppedAnimation<Color>(
                      Colors.white),
                ),
              ),
                  ],
                ),
                onPressed:isDescEntered
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
setState(() {
  isSendingReport = true;
});
Future.delayed(const Duration(seconds: 5), () {
showSuccessModal();
});
  }

  void showSuccessModal() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                return Container(
                  padding: EdgeInsets.all(14),
                  child: Column(
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
                            onTap: (){
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
                      Text(
                        "Great, your schedule calendar has also been sent to your mail. We will contact you shortly",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Lato',
                          color: HexColor("#505050"),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
