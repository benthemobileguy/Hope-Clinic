import 'package:flutter/material.dart';
import 'package:hope_clinic/model/reserved-item.dart';
import 'package:hope_clinic/screens/components/main-button.dart';
import 'package:hope_clinic/screens/shop/product-details-page.dart';
import 'package:hope_clinic/screens/shop/reserved-product-details-page.dart';
import 'package:hope_clinic/theme/style.dart';

class ShopItemReserved extends StatelessWidget {
  final List<ReservedItem> reservedItem;

  const ShopItemReserved({
    Key key,
    this.reservedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6),
      itemCount: reservedItem.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context)
                => ReservedProductsDetailsPage(index:
                index)));
          },
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 130,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color:
                      primaryColor.withOpacity(0.3),
                          width: 2),
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(
                            "${reservedItem[index].store.files[0]}",
                          ))),
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "${reservedItem[index].store.title}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lato',
                      color: normalText,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "${reservedItem[index].store.price}",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lato',
                      color: primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "${reservedItem[index].quantity} Products Reserved",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Lato',
                      color: greyColor2,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: MainButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Icon(
                          Icons.close,
                          color: textRed,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Delete",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Lato',
                            color: textRed,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    color: redBg,
                    onPressed: (){
                     print("we je ");
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
