import 'package:flutter/material.dart';
import 'package:hope_clinic/screens/auth/edit-details-page.dart';
import 'package:hope_clinic/screens/auth/sign-in-page.dart';
import 'package:hope_clinic/screens/components/main-button.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:hope_clinic/utils/color.dart';
import 'package:hope_clinic/utils/global-variables.dart';
import 'package:hope_clinic/utils/links.dart';
import 'package:hope_clinic/utils/pref-manager.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  PrefManager prefManager = PrefManager();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: HexColor("#C4C4C4"),
                      radius: 60,
                      child: ClipOval(
                          child: Image.network(
                        Links.defaultProfileImg,
                        fit: BoxFit.cover,
                        width: 120.0,
                        height: 120.0,
                      )),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: new Image.asset(
                          'images/icons/camera.png',
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  "Stephen Onoka",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                    color: textColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    child: MainButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Image.asset(
                            'images/icons/profile_green.png',
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Edit My Details",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Lato',
                              color: primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      color: lightGreen,
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)
                            => EditDetailsPage()));
                      },
                    ),
                  ),
                  Container(
                   width: MediaQuery.of(context).size.width/2,
                    child: MainButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Image.asset(
                            'images/icons/report.png',
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Doctors Report",
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

                      },
                    ),
                  ),

                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "E-MAIL ADDRESS",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Lato',
                  color: textColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                user.email,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Lato',
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "PHONE NUMBER",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Lato',
                  color: textColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                user.phoneNumber,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Lato',
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FractionallySizedBox(
                widthFactor: 0.5,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: MainButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        new Image.asset(
                          'images/icons/log_out.png',
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Log Out",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Lato',
                            color: textRed,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    color: redBg,
                    onPressed: (){
                      prefManager.clearSharedPreferences().then((value){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)
                            => SignInPage()));
                      });

                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
