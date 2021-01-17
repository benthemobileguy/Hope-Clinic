import 'package:flutter/material.dart';
import 'package:hope_clinic/screens/components/default-text-form-field.dart';
import 'package:hope_clinic/utils/color.dart';
import 'package:hope_clinic/utils/validator.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode emailFocus = new FocusNode(), passwordFocus = new FocusNode();
  String _email, _password;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(
                height: 30,
              ),
              Text(
                "Welcome Back",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Lato',
                  color: HexColor("#444444"),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Provide Your Details To Sign In",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Lato',
                  color: HexColor("#444444"),
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                child: DefaultTextFormField(
                  hintText: "Email or Phone Number",
                  keyboardType: TextInputType.emailAddress,
                  focus: emailFocus,
                  validator: (val) {
                    if (!validateEmail(val)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  nextFocus: passwordFocus,
                  onChanged: (text) {
                    setState(() {
                      _email = text;
                    });
                  },
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                margin: EdgeInsets.only(bottom: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
