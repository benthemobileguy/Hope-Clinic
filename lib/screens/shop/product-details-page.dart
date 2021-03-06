import 'package:flutter/material.dart';
import 'package:hope_clinic/model/market-shop.dart';
import 'package:hope_clinic/screens/components/main-button.dart';
import 'package:hope_clinic/screens/shop/reserved-products-page.dart';
import 'package:hope_clinic/services/shop/index.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductDetailsPage extends StatefulWidget {
  final MarketShop item;

  const ProductDetailsPage({Key key, this.item}) : super(key: key);
  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  MarketService marketService;
  bool isLoading = false;
  StateSetter quantityModalSetter;
  int quantityNo = 1;
  CarouselController buttonCarouselController = CarouselController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    marketService = new MarketService(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Product Details",
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Card(
                  elevation: 2,
                  child: Stack(
                    children: [
                      CarouselSlider(
                        items: widget.item.files.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                margin: EdgeInsets.only(
                                    top: 10, bottom: 10, right: 60, left: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image: NetworkImage(
                                          "${i}",
                                        ))),
                              );
                            },
                          );
                        }).toList(),
                        carouselController: buttonCarouselController,
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 1,
                          aspectRatio: 2.0,
                          initialPage: 0,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        top: 0,
                        child: GestureDetector(
                          onTap: () {
                            buttonCarouselController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.linear);
                          },
                          child: Container(
                              margin: EdgeInsets.only(right: 16),
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                  color: accentColor, shape: BoxShape.circle),
                              child: Icon(
                                Icons.chevron_right,
                                color: primaryColor,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${widget.item.title}",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                  color: normalText,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${widget.item.price}",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${widget.item.desc}",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Lato',
                  color: normalText2,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: MainButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Image.asset(
                        'images/icons/cart.png',
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Reserve Product",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Lato',
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  color: primaryColor,
                  onPressed: () {
                    addQuantityModal();
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void reserveProduct() async {
    Navigator.pop(context);
    setState(() {
      isLoading = true;
    });
    print(quantityNo);
    Map<String, dynamic> data = new Map();
    data = {"quantity": quantityNo.toString(),
      "store_id": widget.item.id};
    try {
      Map<String, dynamic> _res = await marketService.reserveProduct(data);
      setState(() {
        isLoading = false;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context)
              => ReservedProductsPage()));
    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  void addQuantityModal() async {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft:
          Radius.circular(40),
              topRight: Radius.circular(40)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter) {
              quantityModalSetter = stateSetter;
              return Container(
                padding: EdgeInsets.all(14),
                height: 330,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Reserve Product",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14.5,
                        fontFamily: 'Lato',
                        color: textColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Confirm Reservation",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Lato',
                        color: normalTexth1,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      "How many products to be reserved",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14.5,
                        fontFamily: 'Lato',
                        color: normalTexth1,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            quantityModalSetter(() {
                              if(quantityNo>1){
                                quantityNo--;
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: containerBgColor),
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.chevron_left,
                              color: textColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "${quantityNo}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Lato',
                            color: normalTexth1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: (){
                          quantityModalSetter(() {
                            quantityNo++;
                          });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: containerBgColor),
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.chevron_right,
                              color: textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: MainButton(
                        child: Text(
                          "Confirm",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Lato',
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        color: primaryColor,
                        onPressed: () {
                          reserveProduct();
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
