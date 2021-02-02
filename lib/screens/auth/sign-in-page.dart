import 'package:flutter/material.dart';
import 'package:hope_clinic/screens/auth/sign-up-page.dart';
import 'package:hope_clinic/screens/components/default-text-form-field.dart';
import 'package:hope_clinic/screens/components/main-button.dart';
import 'package:hope_clinic/screens/home/base.dart';
import 'package:hope_clinic/services/authentication-service.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:hope_clinic/utils/color.dart';
import 'package:hope_clinic/utils/validator.dart';
import 'package:mdi/mdi.dart';
import 'package:fluttertoast/fluttertoast.dart';
class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  FocusNode emailFocus = new FocusNode(), passwordFocus = new FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false, _loading = false,
      _isInitialised = false;
  String _email, _password;
  AuthenticationService authenticationService;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authenticationService = new AuthenticationService(context: context);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Form(
            key: _formKey,
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
                SizedBox(
                  height: 20,
                ),
                DefaultTextFormField(
                  hintText: "E-mail Address",
                  keyboardType: TextInputType.emailAddress,
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
                SizedBox(
                  height: 10,
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
                  obscureText: !_showPassword,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (text) {
                    setState(() {
                      _password = text;
                    });
                  },
                  suffixIcon: IconButton(
                    icon: _showPassword?
                    Icon(Mdi.eye, color: HexColor("#666666"),)
                        :Icon(Mdi.eyeOff,
                        color: HexColor("#666666")),
                    onPressed: (){
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  )
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Have you forgotten your password?",
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
                      onPressed: () {

                      },
                      child: Text(
                        "Remember Me",
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
                Container(
                  height: 60,
                  child: MainButton(
                    color: primaryColor,
                    child: !_loading ? Text(
                      "Sign In",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Lato',
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ):SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                        new AlwaysStoppedAnimation<Color>(
                            Colors.white),
                      ),
                    ),
                    onPressed: () {
                     signIn();
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
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
                            => SignUpPage()));
                      },
                      child: Text(
                        "Sign Up",
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
        ),
      ),
    );
  }

  void signIn() async{
    if (_formKey.currentState.validate()) {
    setState(() {
      _loading = true;
    });
    try{
      Map<String, dynamic> _res = await
      authenticationService.login(_email, _password);
      Navigator.push(context,
          MaterialPageRoute(builder: (context)
          => Base()));
      setState(() {
        _loading = false;
      });
    }catch(e){
      setState(() {
        _loading = false;
      });
      Fluttertoast.showToast(
        msg: "Login Fail: Your email or password is incorrect.",
        timeInSecForIosWeb: 2,
        toastLength: Toast.LENGTH_LONG,
      );
    }

    }
  }

}
