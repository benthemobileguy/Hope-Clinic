import 'package:flutter/material.dart';
import 'package:hope_clinic/theme/style.dart';
class PainSelection extends StatelessWidget {
  final String title;
  final String image;
  final Color bgColor;

  const PainSelection({Key key, this.title, this.image, this.bgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 1, color: primaryColor.withOpacity(0.5))
      ),
      child:  Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          new Image.asset(image, width: 24, height: 24,),
          SizedBox(
            width: 16,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Lato',
              color: greyColor2,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}