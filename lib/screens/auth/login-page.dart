import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Hero(
              tag:"logo",
              child: new Image.asset(
                'images/logo.png',
                fit: BoxFit.cover,
                width: 167,
                height: 59,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
