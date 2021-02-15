import 'package:flutter/material.dart';
import 'package:hope_clinic/bloc/index.dart';
import 'package:hope_clinic/model/user.dart';
import 'package:hope_clinic/screens/auth/sign-in-page.dart';
import 'package:hope_clinic/screens/components/default-text-form-field.dart';
import 'package:hope_clinic/screens/components/main-button.dart';
import 'package:hope_clinic/screens/home/base.dart';
import 'package:hope_clinic/services/authentication-service.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:hope_clinic/utils/color.dart';
import 'package:hope_clinic/utils/pref-manager.dart';
import 'package:hope_clinic/utils/validator.dart';
import 'package:mdi/mdi.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
class SignUpPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<SignUpPage> {
  AuthenticationService authenticationService;
  int sexBtnIndex = -1;
  int pageindex = 0;
  MainBloc mainBloc;
  bool _isLoading = false;
  TextEditingController dobController = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _confirmPassController = TextEditingController();
  TextEditingController _pinPutController = TextEditingController();

  final FocusNode _pinPutFocusNode = FocusNode();
  BoxDecoration pinPutDecoration = BoxDecoration(
      border: Border.all(color: primaryColor),
      borderRadius: BorderRadius.circular(6));
  bool _showPassword1 = false, _showPassword2 = false, _isInitialised = false;
  String _password1, password2;
  PageController controller = PageController();
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    mainBloc = Provider.of<MainBloc>(context);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authenticationService = new AuthenticationService(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: controller,
            children: [
              SingleChildScrollView(
                child: Form(
                  key: _formKey1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Hero(
                        tag: "logo",
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
                        controller: _firstNameController,
                        textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          if (val == "") {
                            return 'Empty field';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DefaultTextFormField(
                        hintText: "Last Name",
                        controller: _lastNameController,
                        textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          if (val == "") {
                            return 'Empty field';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DefaultTextFormField(
                        controller: _phoneNoController,
                        hintText: "Phone Number",
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val.length != 11) {
                            return 'Please input a valid number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DefaultTextFormField(
                        controller: _emailController,
                        hintText: "E-mail Address",
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (!validateEmail(val)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          DatePicker.showDatePicker(context,
                              theme: DatePickerTheme(
                                containerHeight: 200,
                                headerColor: primaryColor,
                                backgroundColor: Colors.white,
                                itemStyle: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.5),
                                cancelStyle: TextStyle(
                                  fontSize: 16.5,
                                  fontFamily: 'CircularStd',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                                doneStyle: TextStyle(
                                  fontSize: 16.5,
                                  fontFamily: 'CircularStd',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              showTitleActions: true,
                              minTime: DateTime(1930, 00, 00),
                              maxTime: DateTime(2012, 00, 00),
                              onChanged: (date) {}, onConfirm: (date) {
                            setDate(date);
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        },
                        child: DefaultTextFormField(
                          controller: dobController,
                          validator: (val) {
                            if (val == "") {
                              return 'Please enter a date of birth';
                            }
                            return null;
                          },
                          hintText: "Date of Birth",
                          disabled: true,
                          keyboardType: TextInputType.emailAddress,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today_outlined),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  sexBtnIndex = 1;
                                });
                              },
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: containerBgColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                child: Center(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: sexBtnIndex == 1
                                              ? primaryColor
                                              : Colors.white,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 2,
                                            color: sexBtnIndex == 1
                                                ? containerBgColor
                                                : Colors.white,
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
                              onTap: () {
                                setState(() {
                                  sexBtnIndex = 2;
                                });
                              },
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: containerBgColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                child: Center(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: sexBtnIndex == 2
                                              ? primaryColor
                                              : Colors.white,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 2,
                                            color: sexBtnIndex == 2
                                                ? containerBgColor
                                                : Colors.white,
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
                            if (sexBtnIndex != -1 &&
                                _formKey1.currentState.validate()) {
                              controller.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            } else if (_formKey1.currentState.validate() &&
                                sexBtnIndex == -1) {
                              Fluttertoast.showToast(
                                  msg: "Please select your gender",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 4,
                                  backgroundColor: primaryColor,
                                  textColor: HexColor("#FFFFFF"));
                            }
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInPage()));
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
              ),

              ///Page One
              SingleChildScrollView(
                child: Form(
                  key: _formKey2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Hero(
                        tag: "logo",
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
                          controller: _passController,
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
                            icon: _showPassword1
                                ? Icon(
                                    Mdi.eye,
                                    color: HexColor("#666666"),
                                  )
                                : Icon(Mdi.eyeOff, color: HexColor("#666666")),
                            onPressed: () {
                              setState(() {
                                _showPassword1 = !_showPassword1;
                              });
                            },
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      DefaultTextFormField(
                          controller: _confirmPassController,
                          hintText: "Re-Type Password",
                          validator: (val) {
                            if (val != _passController.text) {
                              return 'Password do not match';
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
                            icon: _showPassword2
                                ? Icon(
                                    Mdi.eye,
                                    color: HexColor("#666666"),
                                  )
                                : Icon(Mdi.eyeOff, color: HexColor("#666666")),
                            onPressed: () {
                              setState(() {
                                _showPassword2 = !_showPassword2;
                              });
                            },
                          )),
                      SizedBox(
                        height: 80,
                      ),
                      Container(
                        height: 60,
                        child: MainButton(
                          color: primaryColor,
                          child: !_isLoading
                              ? Text(
                                  "Sign Up",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Lato',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              : SizedBox(
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
                            if (_formKey2.currentState.validate()) {
                              register();
                            }
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInPage()));
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
              ),

              ///Page Two
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Hero(
                      tag: "logo",
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
                      "Enter Verification Code",
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
                      "Please enter the verification code that was sent to your email",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Lato',
                        color: HexColor("#444444"),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    PinPut(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: "OpenSans",
                        color: primaryColor,
                        fontSize: 16,
                      ),
                      eachFieldMargin: EdgeInsets.all(16),
                      keyboardType: TextInputType.text,
                      fieldsCount: 4,
                      fieldsAlignment: MainAxisAlignment.center,
                      eachFieldHeight: 15,
                      eachFieldWidth: 15,
                      onSubmit: (String pin) => {verifyPin(pin)},
                      focusNode: _pinPutFocusNode,
                      controller: _pinPutController,
                      submittedFieldDecoration: pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(6)),
                      pinAnimationType: PinAnimationType.slide,
                      selectedFieldDecoration: pinPutDecoration,
                      followingFieldDecoration: pinPutDecoration.copyWith(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: HexColor("#999999")),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: FlatButton(
                        color: Colors.white,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        minWidth: 40,
                        onPressed: () {},
                        child: Text(
                          "Resend code",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Lato',
                            color: primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   height: 60,
                    //   child: MainButton(
                    //     color: primaryColor,
                    //     child: Text(
                    //       "Sign Up",
                    //       textAlign: TextAlign.start,
                    //       style: TextStyle(
                    //         fontSize: 14,
                    //         fontFamily: 'Lato',
                    //         color: Colors.white,
                    //         fontWeight: FontWeight.w700,
                    //       ),
                    //     ),
                    //     onPressed: () {
                    //
                    //     },
                    //   ),
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       "Already have an account?",
                    //       textAlign: TextAlign.start,
                    //       style: TextStyle(
                    //         fontSize: 14,
                    //         fontFamily: 'Lato',
                    //         color: HexColor("#444444"),
                    //         fontWeight: FontWeight.w400,
                    //       ),
                    //     ),
                    //     FlatButton(
                    //       padding: EdgeInsets.only(left: 5, right: 5),
                    //       minWidth: 40,
                    //       onPressed: () {
                    //         Navigator.push(context,
                    //             MaterialPageRoute(builder: (context)
                    //             => SignInPage()));
                    //       },
                    //       child: Text(
                    //         "Sign In",
                    //         textAlign: TextAlign.start,
                    //         style: TextStyle(
                    //           fontSize: 14,
                    //           fontFamily: 'Lato',
                    //           color: primaryColor,
                    //           fontWeight: FontWeight.w700,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                  ],
                ),
              ),

              ///Page Three
            ],
          ),
        ),
      ),
    );
  }

  verifyPin(String pin) async {
    Map<String, String> data = new Map();
    data = {"verify_code": pin};
    PrefManager prefManager = PrefManager();
    Map<String, dynamic> _res = await authenticationService.verifyOTP(data);
    if (_res['status_code'] == 200) {
      prefManager.setAuthToken(_res['token']).then((value){
        Navigator.push(context,
            MaterialPageRoute(builder: (context)
            => Base()));
      });
    } else{
      
      Fluttertoast.showToast(
        msg: _res["message"],
        timeInSecForIosWeb: 2,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  void setDate(DateTime date) {
    setState(() {
      dobController.text = date.toString().substring(0, 10);
    });
  }

  void register() async {
    setState(() {
      _isLoading = true;
    });
    Map<String, String> data = new Map();
    data = {
      "firstname": _firstNameController.text.trim(),
      "lastname": _lastNameController.text.trim(),
      "phone_number": _phoneNoController.text.trim(),
      "email": _emailController.text.trim(),
      "dob": dobController.text,
      "password": _confirmPassController.text.trim(),
      "role": "patient"
    };
    try {
      Map<String, dynamic> _res = await authenticationService.register(data);
      PrefManager prefManager = PrefManager();
      prefManager.setUserData(_res['user'])
          .then((value) {
     mainBloc.user = User.fromJson(_res['user']);
        if (_formKey2.currentState.validate()) {
          controller.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        }
      });
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
        msg: "The email has already been taken!",
        timeInSecForIosWeb: 2,
        toastLength: Toast.LENGTH_LONG,
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<bool> onWillPop() {
    if(controller.page !=0){
      controller.previousPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else{
      Navigator.pop(context);
    }
    return null;
  }
}
