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
  List<MarketShop> shopList = [];
  MainBloc bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    bloc.fetchMarketShop(context);
    return shopList;
  }

}
