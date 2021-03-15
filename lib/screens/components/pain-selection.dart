import 'package:flutter/material.dart';
import 'package:hope_clinic/theme/style.dart';
class PainSelection extends StatelessWidget {
  final String title;
  final String image;

  const PainSelection({Key key, this.title, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 1, color: primaryColor.withOpacity(0.5))
      ),
      child:  Row(
        children: [
          new Image.asset("images/fire.ng", width: 24, height: 24,),
          Text(
            "Sharp Pain",
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