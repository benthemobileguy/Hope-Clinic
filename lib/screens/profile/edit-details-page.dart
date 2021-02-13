import 'package:flutter/material.dart';
import 'package:hope_clinic/screens/components/default-text-form-field.dart';
import 'package:hope_clinic/screens/components/main-button.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:hope_clinic/utils/global-variables.dart';
import 'package:hope_clinic/utils/validator.dart';
class EditDetailsPage extends StatefulWidget {
  @override
  _EditDetailsPageState createState() => _EditDetailsPageState();
}

class _EditDetailsPageState extends State<EditDetailsPage> {
  TextEditingController _emailController = TextEditingController(text: user.email);
  TextEditingController _phoneNoController = TextEditingController(text: user.phoneNumber);
  TextEditingController _dobController = TextEditingController(text: user.email);
  TextEditingController _firstNameController = TextEditingController(text: user.firstname);
  TextEditingController _lastNameController = TextEditingController(text: user.lastname);
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
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
                  child: Row(
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
    Navigator.pop(context);
    }
  }
}
