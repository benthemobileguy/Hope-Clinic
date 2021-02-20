import 'package:flutter/material.dart';
import 'package:hope_clinic/theme/style.dart';
class ReservedProducts extends StatefulWidget {
  @override
  _ReservedProductsState createState() => _ReservedProductsState();
}

class _ReservedProductsState extends State<ReservedProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Reserved For Me",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Lato',
            color: textColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 30,
          ),
          color: textColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
