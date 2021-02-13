import 'package:flutter/material.dart';
import 'package:hope_clinic/screens/components/default-text-form-field.dart';
import 'package:hope_clinic/screens/components/main-button.dart';
import 'package:hope_clinic/services/authentication-service.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:hope_clinic/utils/global-variables.dart';
import 'package:hope_clinic/utils/validator.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
class EditDetailsPage extends StatefulWidget {
  @override
  _EditDetailsPageState createState() => _EditDetailsPageState();
}

class _EditDetailsPageState extends State<EditDetailsPage> {
  AuthenticationService authenticationService;
  TextEditingController _emailController = TextEditingController(text: user.email);
  TextEditingController _phoneNoController = TextEditingController(text: user.phoneNumber);
  TextEditingController _dobController = TextEditingController(text: user.dob);
  TextEditingController _firstNameController = TextEditingController(text: user.firstname);
  TextEditingController _lastNameController = TextEditingController(text: user.lastname);
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authenticationService = new AuthenticationService(context: context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Edit My Details",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Lato',
            color: textColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.chevron_left,
            size: 30,),
          color: textColor,
          onPressed: () {
          Navigator.pop(context);
          },),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                DefaultTextFormField(
                  controller: _firstNameController,
                  hintText: "First Name",
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Empty field';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 14,
                ),
                DefaultTextFormField(
                  controller: _lastNameController,
                  hintText: "Last Name",
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Empty field';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 14,
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
                  height: 14,
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
                    controller: _dobController,
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
                  height: 14,
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
                  height: 20,
                ),
                MainButton(
                  child: !isLoading?Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Image.asset(
                        'images/icons/tick_square.png',
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Save",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Lato',
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ):SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor:
                      new AlwaysStoppedAnimation<Color>(
                          Colors.white),
                    ),
                  ),
                  color: primaryColor,
                  onPressed: (){
                   editProfile();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void editProfile() async{
    if(_formKey.currentState.validate()){
     setState(() {
       isLoading = true;
     });
    }
  }

  void setDate(DateTime date) {
    setState(() {
      _dobController.text = date.toString().substring(0, 10);
    });

  }
}
