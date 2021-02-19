import 'package:flutter/material.dart';
import 'package:hope_clinic/bloc/index.dart';
import 'package:hope_clinic/model/market-shop.dart';
import 'package:hope_clinic/model/shop-item.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  List<Shop> shopItem = [];
  MainBloc bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shopItem.add(Shop(title: "Organic Ginger Balm",
        image: "images/img_1.png", price: "5,000"));
    shopItem.add(Shop(title: "Pure Memory Foam Knee Pillow",
        image: "images/img_2.png", price: "15,000"));
    shopItem.add(Shop(title: "Premium Gel Cool Neck Memory Foam Pillow",
        image: "images/img_1.png", price: "25,000"));
    shopItem.add(Shop(title: "HOPE Gift Vouchers",
        image: "images/img_1.png", price: "50,000"));
  }
  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    bloc = Provider.of<MainBloc>(context, listen: false);
   await getMarketShop();
  }
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
            // ShopItem(shopItem: shopItem,),
            Expanded(
              child: Center(
                child: SpinKitRipple(
                  borderWidth: 6,
                  color: primaryColor,
                  size: 60.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<List<MarketShop>> getMarketShop() async {
    bloc.fetchTrips(context, operatorData.id,
        "0", tripType).then((value) => {
      setState(() {
        trips = value;
      }),
    });
    return trips;
  }

}
