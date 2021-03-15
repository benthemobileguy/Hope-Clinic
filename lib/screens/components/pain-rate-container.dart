import 'package:flutter/material.dart';
import 'package:emojis/emojis.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:hope_clinic/utils/color.dart';
class PainRateContainer extends StatelessWidget {
final String emoji;
final String title;
final Color bgColor;

  const PainRateContainer({Key key, this.emoji, this.title, this.bgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          child: Center(
            child: Text(
              emoji,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Lato',
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.all(Radius.circular(16)),
              border: Border.all(width: 1)),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'Lato',
              color: primaryColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}