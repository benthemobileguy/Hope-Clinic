import 'package:flutter/material.dart';
import 'package:hope_clinic/theme/style.dart';

import 'package:mdi/mdi.dart';

void showImagePicker(BuildContext context, Function cameraFunction, galleryFunction) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0))),
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 14),
          margin: EdgeInsets.only(top: 20),
          decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  width: 10,
                  child: Divider(
                    thickness: 0.5,
                    color: Color(0xFFD5DDE0),
                  )),

              Text(
                'Update profile picture',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Lato',
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20.0,
              ),
              FlatButton(
                onPressed: cameraFunction,
                child: Row(
                  children: [
                    Text(
                      "From Camera",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Mdi.chevronRight,
                      color: Colors.black,
                    )

                  ],
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              FlatButton(
                onPressed: galleryFunction,
                child: Row(
                  children: [
                    Text(
                      "From File Explorer",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Mdi.chevronRight,
                      color: Colors.black,
                    )

                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        );
      });
}