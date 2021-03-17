import 'package:flutter/material.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:bubble/bubble.dart';
class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double px = 1 / pixelRatio;

    BubbleStyle styleSomebody = BubbleStyle(
      nip: BubbleNip.leftTop,
      color: Colors.white,
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
            Bubble(
              alignment: Alignment.center,
              color: Color.fromARGB(255, 212, 234, 244),
              elevation: 1 * px,
              margin: BubbleEdges.only(top: 8.0),
              child: Text('TODAY', style: TextStyle(fontSize: 10)),
            ),
            Bubble(
              style: styleSomebody,
              child: Text('Hi Doctor, i just scheduled the appointment as you instructed',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Lato',
                  color: chatTextColor,
                  fontWeight: FontWeight.normal,
                ),),
            ),
            Bubble(
              style: styleMe,
              child: Text('Good to know! See you morning time',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Lato',
                  color: chatTextColor,
                  fontWeight: FontWeight.normal,
                ),),
            ),
            Bubble(
              style: styleSomebody,
              child: Text('Any requirement needed while coming?',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Lato',
                  color: chatTextColor,
                  fontWeight: FontWeight.normal,
                ),),
            ),
            Bubble(
              style: styleSomebody,
              margin: BubbleEdges.only(top: 2.0),
              nip: BubbleNip.no,
              child: Text('Not at all. Just come with your card',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Lato',
                  color: chatTextColor,
                  fontWeight: FontWeight.normal,
                ),),
            ),
            Bubble(
              style: styleMe,
              child: Text('Okay, Thanks',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Lato',
                  color: chatTextColor,
                  fontWeight: FontWeight.normal,
                ),),
            ),
            Bubble(
              style: styleMe,
              nip: BubbleNip.no,
              margin: BubbleEdges.only(top: 2.0),
              child: Text('See you soon!', style: TextStyle(
                fontSize: 14,
                fontFamily: 'Lato',
                color: chatTextColor,
                fontWeight: FontWeight.normal,
              ),),
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
                FlatButton(
                  color: primaryColor,
                  onPressed: (){
                    messageController.text == "";
                  },
                  child: Image.asset('images/send.png',
                    width: 24,height: 24,),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
