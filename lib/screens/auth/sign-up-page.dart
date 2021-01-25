import 'package:flutter/material.dart';
import 'package:hope_clinic/screens/auth/sign-in-page.dart';
import 'package:hope_clinic/screens/components/default-text-form-field.dart';
import 'package:hope_clinic/screens/components/main-button.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:hope_clinic/utils/color.dart';
import 'package:mdi/mdi.dart';
class SignUpPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<SignUpPage> {
  int sexBtnIndex = -1;
  int pageindex = 0;
  bool _showPassword1 = false, _showPassword2 = false,
      _isInitialised = false;
  String _password1, password2;
  PageController controller = PageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: PageView(
            controller: controller,
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
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
                      "Welcome",
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
                      "Provide Your Details To Sign Up",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Lato',
                        color: HexColor("#444444"),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DefaultTextFormField(
                      hintText: "First Name",
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.text,


                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DefaultTextFormField(
                      hintText: "Last Name",
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.text,

                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DefaultTextFormField(
                      hintText: "Phone Number",
                      keyboardType: TextInputType.number,


                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DefaultTextFormField(
                      hintText: "E-mail Address",
                      keyboardType: TextInputType.emailAddress,


                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DefaultTextFormField(
                      hintText: "Date of Birth",
                      disabled: true,
                      keyboardType: TextInputType.emailAddress,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today_outlined),
                        onPressed: () {  },
                      ),

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
                                sexBtnIndex = 1;
                              });
                            },
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: containerBgColor,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(12)),
                              ),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: sexBtnIndex==1?
                                        primaryColor:Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 2,
                                          color: sexBtnIndex==1?containerBgColor:Colors.white,
                                        ),
                                      ),

                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      "Male",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Lato',
                                        color: textColor,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                sexBtnIndex = 2;
                              });
                            },
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: containerBgColor,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(12)),
                              ),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: sexBtnIndex==2?
                                        primaryColor:Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 2,
                                          color: sexBtnIndex==2?
                                          containerBgColor:Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      "Female",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Lato',
                                        color: textColor,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 60,
                      child: MainButton(
                        color: primaryColor,
                        child: Text(
                          "Next",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Lato',
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {
                          controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Lato',
                            color: HexColor("#444444"),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        FlatButton(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          minWidth: 40,
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)
                                => SignInPage()));
                          },
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
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
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
                      "Welcome",
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
                      "Provide Your Details To Sign Up",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Lato',
                        color: HexColor("#444444"),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DefaultTextFormField(
                        hintText: "Password",
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Password cannot be empty';
                          }
                          if (val.length < 6) {
                            return 'Minimum characters is 6';
                          }
                          return null;
                        },
                        obscureText: !_showPassword1,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (text) {
                          setState(() {
                            _password1 = text;
                          });
                        },
                        suffixIcon: IconButton(
                          icon: _showPassword1?
                          Icon(Mdi.eye, color: HexColor("#666666"),)
                              :Icon(Mdi.eyeOff,
                              color: HexColor("#666666")),
                          onPressed: (){
                            setState(() {
                              _showPassword1 = !_showPassword1;
                            });
                          },
                        )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DefaultTextFormField(
                        hintText: "Re-Type Password",
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Password cannot be empty';
                          }
                          if (val.length < 6) {
                            return 'Minimum characters is 6';
                          }
                          return null;
                        },
                        obscureText: !_showPassword2,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (text) {
                          setState(() {
                            _password1 = text;
                          });
                        },
                        suffixIcon: IconButton(
                          icon: _showPassword2?
                          Icon(Mdi.eye, color: HexColor("#666666"),)
                              :Icon(Mdi.eyeOff,
                              color: HexColor("#666666")),
                          onPressed: (){
                            setState(() {
                              _showPassword2 = !_showPassword2;
                            });
                          },
                        )
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Container(
                      height: 60,
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

                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Lato',
                            color: HexColor("#444444"),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        FlatButton(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          minWidth: 40,
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)
                                => SignInPage()));
                          },
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
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }
}
