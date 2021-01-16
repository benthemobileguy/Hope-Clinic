import 'package:flutter/material.dart';
class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Hero(
              tag:"logo",
              child: new Image.asset(
                'images/logo.png',
                fit: BoxFit.cover,
                width: 167,
                height: 59,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
