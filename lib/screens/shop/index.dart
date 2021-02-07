import 'package:flutter/material.dart';
import 'package:hope_clinic/screens/shop/components/shop-item.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:hope_clinic/utils/color.dart';
class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hope Store",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Lato',
                color: primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ShopItem(),
          ],
        ),
      ),
    );
  }
}
