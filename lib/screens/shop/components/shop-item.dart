import 'package:flutter/material.dart';
import 'package:hope_clinic/theme/style.dart';

class ShopItem extends StatelessWidget {
  const ShopItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                  color: Colors.white,
                  child: new Image.asset(
                    'images/img_1.png',
                    width: 150,
                    height: 180,
                  )),
              Text(
                "Organic Ginger Balm",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Lato',
                  color: normalText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "5,000",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
