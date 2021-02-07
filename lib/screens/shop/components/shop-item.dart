import 'package:flutter/material.dart';
import 'package:hope_clinic/model/shop-item.dart';
import 'package:hope_clinic/screens/shop/product-details.dart';
import 'package:hope_clinic/theme/style.dart';

class ShopItem extends StatelessWidget {
  final List<Shop> shopItem;

  const ShopItem({
    Key key,
    this.shopItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: shopItem.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)
                  => ProductDetails(item: shopItem[index])));
            },
            child: Container(
              child: Column(
                children: [
                  Container(
                      color: Colors.white,
                      child: new Image.asset(
                        shopItem[index].image,
                        width: double.infinity,
                        height: 120,
                      )),
                  Text(
                    shopItem[index].title,
                    textAlign: TextAlign.center,
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
                    "${shopItem[index].price}",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lato',
                      color: primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
