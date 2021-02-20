import 'package:flutter/material.dart';
import 'package:hope_clinic/bloc/index.dart';
import 'package:hope_clinic/model/market-shop.dart';
import 'package:hope_clinic/screens/components/main-button.dart';
import 'package:hope_clinic/screens/shop/components/shop-item.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  List<MarketShop> shopList;
  MainBloc bloc;
  bool isInitialised = false;
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

  }
  @override
  Widget build(BuildContext context) {
    if(!isInitialised){
      getMarketShop();
      isInitialised = true;
    }
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Hope Store",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Lato',
                    color: primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
               Spacer(),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    width: 138,
                    height: 60,
                    child: MainButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Image.asset(
                            'images/icons/cart.png',
                            color: primaryColor,
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              "Reserved",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Lato',
                                color: primaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      color: accentColor,
                      onPressed: (){

                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            shopList==null?
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
            ShopItem(shopItem:
            shopList,)),
          ],
        ),
      ),
    );
  }
  Future<List<MarketShop>> getMarketShop() async {
    bloc.fetchMarketShop(context).then((value) {
      setState(() {
        shopList = value;
        print(shopList.toString());
      });
    });
    return shopList;
  }

}
