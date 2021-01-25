import 'package:flutter/material.dart';
import 'package:hope_clinic/screens/auth/sign-in-page.dart';
import 'package:hope_clinic/screens/auth/sign-up-page.dart';
import 'package:hope_clinic/theme/style.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "You are logged in!",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Lato',
                color: primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          FlatButton(
            color: primaryColor,
            padding: EdgeInsets.only(left: 10, right: 10),
            minWidth: 40,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)
                  =>SignInPage()));
            },
            child: Text(
              "Log Out",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Lato',
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
