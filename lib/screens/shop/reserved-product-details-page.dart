import 'package:flutter/material.dart';
import 'package:hope_clinic/bloc/index.dart';
import 'package:hope_clinic/screens/components/main-button.dart';
import 'package:hope_clinic/services/shop/index.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
class ReservedProductsDetailsPage extends StatefulWidget {
  final int index;

  const ReservedProductsDetailsPage({Key key, this.index}) : super(key: key);
  @override
  _ReservedProductsDetailsPageState createState() => _ReservedProductsDetailsPageState();
}

class _ReservedProductsDetailsPageState extends State<ReservedProductsDetailsPage> {
  MainBloc mainBloc;
  bool isLoading = false;
  MarketService marketService;
  CarouselController buttonCarouselController = CarouselController();
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    mainBloc = Provider.of<MainBloc>(context);
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
                        items: mainBloc.reservedItem[widget.index].store.files.map((i) {
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
                "${ mainBloc.reservedItem[widget.index].store.title}",
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
                "${mainBloc.reservedItem[widget.index].store.price}",
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
                "${mainBloc.reservedItem[widget.index].store.desc}",
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
                  child: isLoading? SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor:
                      new AlwaysStoppedAnimation<Color>(
                          Colors.redAccent),
                    ),
                  ):Row(
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
                  onPressed: () {
                    deleteProduct();
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

  void deleteProduct() async{
setState(() {
  isLoading = true;
});
try{
  marketService.deleteReservedItem(
      mainBloc.reservedItem[widget.index].store.id.toString());
  setState(() {
    isLoading = false;
  });
}catch(e){
  print(e.toString());
  setState(() {
    isLoading = false;
  });
}

  }
}
