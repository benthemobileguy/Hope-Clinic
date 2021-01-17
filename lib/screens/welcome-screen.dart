import 'package:flutter/material.dart';
import 'package:hope_clinic/screens/auth/login-page.dart';
import 'package:hope_clinic/screens/auth/register-page.dart';
import 'package:hope_clinic/screens/components/main-button.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:hope_clinic/utils/color.dart';
class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Spacer(),
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
          Spacer(),
            Container(
              height: 50,
              child: MainButton(
                color: primaryColor,
                child: Text(
                  "Sign Up",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Lato',
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)
                      => RegisterPage()));
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              child: MainButton(
                color: accentColor,
                child: Text(
                  "Sign In",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Lato',
                    color: primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)
                      => LoginPage()));
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
