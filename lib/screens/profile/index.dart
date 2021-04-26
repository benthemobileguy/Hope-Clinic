import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hope_clinic/bloc/index.dart';
import 'package:hope_clinic/model/user.dart';
import 'package:hope_clinic/screens/components/show-image-picker.dart';
import 'package:hope_clinic/screens/profile/edit-details-page.dart';
import 'package:hope_clinic/screens/auth/sign-in-page.dart';
import 'package:hope_clinic/screens/components/main-button.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:hope_clinic/utils/alert-manager.dart';
import 'package:hope_clinic/utils/color.dart';
import 'package:hope_clinic/utils/constants.dart';
import 'package:hope_clinic/utils/links.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:hope_clinic/utils/pref-manager.dart';
import 'package:dio/dio.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  PrefManager prefManager = PrefManager();
  MainBloc mainBloc;
  PickedFile _image;
  final picker = ImagePicker();
  ProgressDialog pr;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    mainBloc = Provider.of<MainBloc>(context);
    print(mainBloc.user.profilePhotoUrl);
  }
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
                child: FlatButton(
                  onPressed: (){
                    showImagePicker(context, () {
                      getImageFromCamera();
                    }, () {
                      getImageFromGallery();
                    });
                  },
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: HexColor("#C4C4C4"),
                        radius: 60,
                        child: ClipOval(
                            child: Image.network(
                          mainBloc.user.profilePhotoUrl!="hope_clinic/hope_clinic.png"?
                          Links.cloudinaryLink+mainBloc.user.profilePhotoUrl:Links.defaultProfileImg,
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
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  '${mainBloc.user.firstname} ${mainBloc.user.lastname}',
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
                  Expanded(
                    child: Container(
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
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
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
                              "View Reports",
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
                mainBloc.user.email,
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
                mainBloc.user.phoneNumber,
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
                        mainBloc.bearerToken = null;
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

  void getImageFromCamera() async{
    var selectedImg = await picker.getImage(source: ImageSource.camera, maxHeight: 480, maxWidth: 640);
    if (selectedImg != null) {
      pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
      //Dialog Style
      pr.style(
        message: 'Uploading your image...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor:  new AlwaysStoppedAnimation<Color>(
              primaryColor),
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.bounceIn,
        progressTextStyle: TextStyle(color: customTextColor, fontSize: 14.0),
        messageTextStyle: TextStyle(color: customTextColor, fontSize: 14.0),
      );
      setState(() {
        _image = selectedImg;
      });
      uploadtoServer(_image);
      Navigator.pop(context);
      pr.show();
    }
  }

  void getImageFromGallery() async{
    var selectedImg = await picker.getImage(source: ImageSource.gallery,maxHeight: 480, maxWidth: 640);
    if (selectedImg != null) {
      pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
      //Dialog Style
      pr.style(
        message: 'Uploading your image...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor:  new AlwaysStoppedAnimation<Color>(
              primaryColor),
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.bounceIn,
        progressTextStyle: TextStyle(color: customTextColor, fontSize: 14.0),
        messageTextStyle: TextStyle(color: customTextColor, fontSize: 14.0),
      );
      setState(() {
        _image = selectedImg;
      });
      uploadtoServer(_image);
      Navigator.pop(context);
      pr.show();
    }
  }

  Future<List<dynamic>> uploadtoServer(PickedFile image) async {
    Dio dio = new Dio();
    String fileName = image.path
        .split('/')
        .last;
    print(image.path);
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(
          image.path,
          filename: fileName),
    });
    try {
      Response response = await dio.post(
          Constants().API_BASE_URL +
              "user/upload/image",
          data: formData,
          options: Options(
              responseType: ResponseType.json,
              headers: {
                "Authorization": "Bearer ${mainBloc.bearerToken}",
                "Accept": "application/json",
              }
          ));
       print("res"+response.data.toString());
       print(response.statusCode.toString());
       if(response.data[0]["status"] == true){
         setState(() {
           mainBloc.user.profilePhotoUrl = Links.cloudinaryLink+
               response.data[1]['profile_photo_url'];

         });
         prefManager.setUserData(response.data[1]);
         mainBloc.user = User.fromJson(response.data[1]);
       }
      pr.hide();
      print("This is the form data response: ${response.data}");
      return response.data;
    } catch (e) {
      print(e.toString());
      AlertManager.showToast(e.toString());
      pr.hide();
    }
  }
}
