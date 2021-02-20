import 'package:flutter/material.dart';
import 'package:hope_clinic/bloc/index.dart';
import 'package:hope_clinic/model/reserved-item.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:provider/provider.dart';
class ReservedProducts extends StatefulWidget {
  @override
  _ReservedProductsState createState() => _ReservedProductsState();
}

class _ReservedProductsState extends State<ReservedProducts> {
  List<ReservedItem> reservedItems;
  MainBloc bloc;
  bool isInitialised = false;
  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    bloc = Provider.of<MainBloc>(context, listen: false);

  }
  @override
  Widget build(BuildContext context) {
    if(!isInitialised){
      getReservedProducts();
      isInitialised = true;
    }
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

  void getReservedProducts() async{

  }
}
