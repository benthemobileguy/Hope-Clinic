import 'package:flutter/material.dart';
import 'package:hope_clinic/bloc/index.dart';
import 'package:hope_clinic/model/message.dart';
import 'package:hope_clinic/screens/book-appointment/index.dart';
import 'package:hope_clinic/screens/components/main-button.dart';
import 'package:hope_clinic/services/appointment/index.dart';
import 'package:hope_clinic/services/authentication-service.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:bubble/bubble.dart';
import 'package:hope_clinic/utils/alert-manager.dart';
import 'package:hope_clinic/utils/color.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  TextEditingController messageController = TextEditingController();
  MainBloc mainBloc;
  ScrollController _scrollController = new ScrollController();

  String messageType = "";
  int msgTypeIndex = -1;
  AppointmentService appointmentService;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appointmentService = new AppointmentService(context: context);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    mainBloc = Provider.of<MainBloc>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double px = 1 / pixelRatio;

    BubbleStyle styleSomebody = BubbleStyle(
      nip: BubbleNip.leftTop,
      color: lightGreen,
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, right: 50.0),
      alignment: Alignment.topLeft,
    );
    BubbleStyle styleMe = BubbleStyle(
      nip: BubbleNip.rightTop,
      color: bubbleMsg,
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, left: 50.0),
      alignment: Alignment.topRight,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Message",
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Expanded (
              child: ListView(
                controller: _scrollController,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('images/robot.svg'),
                      SizedBox(
                        width: 10,
                      ),
                      Bubble(
                        style: styleSomebody,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            'Hi, ${mainBloc.user.firstname}, '
                            'how can I help you?\nYou can select any options below\nbelow if it'
                            ' applies to you',
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              fontFamily: 'Lato',
                              color: chatTextColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: _getListings(styleMe),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    child: TextField(
                      controller: messageController,
                      cursorColor: textColor,
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
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12.0)),
                          hintText: 'Type your message here'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ButtonTheme(
                  minWidth: 48,
                  height: 50,
                  child: RaisedButton(
                    padding: EdgeInsets.all(0),
                    color: primaryColor,
                    onPressed: () {
                      if (messageController.text != "") {
                        showBottomSheetOptions();
                      }
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(16)),
                    child: Image.asset(
                      'images/send.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendMessage() async {
    print(messageController.text);
    Navigator.pop(context);
    Map<String, dynamic> data = new Map();
    data = {
      "type": messageType,
      "receiver_id":mainBloc.user.id,
      "message": messageController.text
    };
    Map<String, dynamic> _res = await appointmentService.sendMessage(data);
    if (_res["status"] == "success") {
     setState(() {
       mainBloc.message.add(Message(type: messageType, message: messageController.text));
       msgTypeIndex = -1;
     });
     messageController.clear();
    }
  }

  void showBottomSheetOptions() {
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
                  Center(
                    child: Text(
                      messageController.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Lato',
                        color: HexColor("#505050"),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              msgTypeIndex = 1;
                              messageType = "pain-in-the-body";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: msgTypeIndex == 1
                                    ? primaryColor
                                    : containerBgColor,
                                borderRadius: BorderRadius.all(Radius.circular(12))),
                            child: Text(
                              "Pain In The Body",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Lato',
                                color: msgTypeIndex == 1
                                    ? Colors.white
                                    : HexColor('#666666'),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              msgTypeIndex = 2;
                              messageType = "missed-appointment";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: msgTypeIndex == 2
                                    ? primaryColor
                                    : containerBgColor,
                                borderRadius: BorderRadius.all(Radius.circular(12))),
                            child: Text(
                              "Missed Appointment",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Lato',
                                color: msgTypeIndex == 2
                                    ? Colors.white
                                    : HexColor('#666666'),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              msgTypeIndex = 3;
                              messageType = "leave-a-review";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: msgTypeIndex == 3
                                    ? primaryColor
                                    : containerBgColor,
                                borderRadius: BorderRadius.all(Radius.circular(12))),
                            child: Text(
                              "Leave A Review",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Lato',
                                color: msgTypeIndex == 3
                                    ? Colors.white
                                    : HexColor('#666666'),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              msgTypeIndex = 4;
                              messageType = "complaint";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: msgTypeIndex == 4
                                    ? primaryColor
                                    : containerBgColor,
                                borderRadius: BorderRadius.all(Radius.circular(12))),
                            child: Text(
                              "Complaint",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Lato',
                                color: msgTypeIndex == 4
                                    ? Colors.white
                                    : HexColor('#666666'),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 60,
                    child: MainButton(
                      color: primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Send Message",
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
                        if(msgTypeIndex!=-1){
                          sendMessage();
                        }else{
                          AlertManager.showToast("Please select a message option");
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }
  List<Widget> _getListings(BubbleStyle styleMe) { // <<<<< Note this change for the return type
    List listings = <Widget>[];
    int i = 0;
    for (i = 0; i < mainBloc.message.length; i++) {
      listings.add(
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: greyColor2,
                    width: 1,

                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              child: Text(
                mainBloc.message[i].type,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  fontFamily: 'Lato',
                  color: normalTextBold,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Bubble(
              style: styleMe,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  mainBloc.message[i].message,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    fontFamily: 'Lato',
                    color: chatTextColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      );
    }
    return listings;
  }
}
