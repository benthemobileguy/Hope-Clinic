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
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12.0)),
                          hintText: 'Type your message here'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: Center(child:
                  Image.asset('images/send.png', width: 24,height: 24,)),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  width: 48,
                  height: 50,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
