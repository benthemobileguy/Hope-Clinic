import 'package:flutter/material.dart';
import 'package:hope_clinic/bloc/index.dart';
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
  String messageType = "";
  int msgTypeIndex = -1;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    mainBloc = Provider.of<MainBloc>(context, listen: false);
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
      color: Color.fromARGB(255, 225, 255, 199),
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
                    child: Text('Hi, ${mainBloc.user.firstname}, '
                        'how can I help you?\nYou can select any options below\nbelow if it'
                        ' applies to you',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        fontFamily: 'Lato',
                        color: chatTextColor,
                        fontWeight: FontWeight.normal,
                      ),),
                  ),
                ),

              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        msgTypeIndex = 1;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: msgTypeIndex==1?
                        primaryColor:
                        containerBgColor,
                        borderRadius: BorderRadius.all(Radius.circular(12))
                      ),
                      child: Text(
                        "Pain In The Body",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Lato',
                          color:msgTypeIndex==1?Colors.white: HexColor('#666666'),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        msgTypeIndex = 2;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: msgTypeIndex==2?primaryColor:containerBgColor,
                          borderRadius: BorderRadius.all(Radius.circular(12))
                      ),
                      child: Text(
                        "Missed Appointment",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Lato',
                          color: msgTypeIndex==2?Colors.white:HexColor('#666666'),
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
                    onTap: (){
                      setState(() {
                        msgTypeIndex = 3;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: msgTypeIndex==3?primaryColor:containerBgColor,
                          borderRadius: BorderRadius.all(Radius.circular(12))
                      ),
                      child: Text(
                        "Leave A Review",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Lato',
                          color: msgTypeIndex==3?Colors.white:HexColor('#666666'),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        msgTypeIndex = 4;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: msgTypeIndex==4?primaryColor:containerBgColor,
                          borderRadius: BorderRadius.all(Radius.circular(12))
                      ),
                      child: Text(
                        "Complaint",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Lato',
                          color: msgTypeIndex==4?Colors.white:HexColor('#666666'),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
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
                    onPressed: (){
                      if(msgTypeIndex!=-1){
                        if(messageController.text!=""){
                          setState(() {
                            msgTypeIndex = -1;
                            messageController.clear();
                          });
                          AlertManager.showShortToast("Your message has been sent!");
                        }

                      } else{
                        AlertManager.showShortToast("Please select a message type");
                      }

                    },
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(16)
                    ),
                    child: Image.asset('images/send.png',
                      width: 24,height: 24,),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
