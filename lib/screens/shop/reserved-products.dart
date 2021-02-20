import 'package:flutter/material.dart';
import 'package:hope_clinic/bloc/index.dart';
import 'package:hope_clinic/model/reserved-item.dart';
import 'package:hope_clinic/screens/shop/components/shop-item-reserved.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class ReservedProducts extends StatefulWidget {
  @override
  _ReservedProductsState createState() => _ReservedProductsState();
}

class _ReservedProductsState extends State<ReservedProducts> {
  List<ReservedItem> reservedItems;
  MainBloc bloc;
  List<ReservedItem> reservedList;
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
      body: reservedList==null?
      Expanded(
        child: Center(
          child: SpinKitRipple(
            borderWidth: 8,
            color: primaryColor,
            size: 100.0,
          ),
        ),
      ):
      Expanded(child:
      ShopItemReserved(reservedItem:
      reservedList,)),
    );
  }
  Future<List<ReservedItem>> getReservedProducts() async {
    bloc.fetchReservedProducts(context).then((value) {
      setState(() {
        reservedList = value;
      });
    });
    return reservedList;
  }
}
