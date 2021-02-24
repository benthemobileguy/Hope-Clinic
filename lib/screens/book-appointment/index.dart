import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hope_clinic/bloc/index.dart';
import 'package:hope_clinic/screens/components/main-button.dart';
import 'package:hope_clinic/shimmers/shimmer-list-view.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:hope_clinic/utils/color.dart';
import 'package:provider/provider.dart';
import 'package:mdi/mdi.dart';
class BookAppointment extends StatefulWidget {
  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  bool isDataLoaded = false;
  bool isInitialised = false;
  int globalIndex = -1;
  MainBloc bloc;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    bloc = Provider.of<MainBloc>(context);
  }
  @override
  Widget build(BuildContext context) {
    if (!isInitialised) {
      fetchRequests();
      isInitialised = true;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Book An Appointment",
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
        padding: const EdgeInsets
            .symmetric(horizontal: 14),
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "SELECT A PACKAGE",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Lato',
                color: textColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 14,
            ),
            !isDataLoaded?ShimmerListView():
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: bloc.packages.length,
                  itemBuilder: (context, index){
                    return Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.
                            all(Radius.circular(12)),
                            side: BorderSide(color:
                            borderColor, width: 1)
                        ),
                        child: Container(
                          padding: EdgeInsets.only(left: 16, right: 16, bottom: 20),
                          child:  Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    bloc.packages[index].title,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Lato',
                                      color: primaryColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Spacer(),
                                  new IconButton(
                                    padding: EdgeInsets.only(top: 30),
                                    color: textColor,
                                      icon:
                                  Icon(!bloc.packages[index].isTapped?
                                  Mdi.chevronDown: Mdi.chevronUp),
                                      onPressed: (){
                                    setState(() {
                                      globalIndex = index;
                                      bloc.packages[index].isTapped =
                                      ! bloc.packages[index].isTapped;
                                    });

                                      })
                                ],
                              ),
                              Text(
                                bloc.packages[index].desc,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Lato',
                                  color: textColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              bloc.packages[index].isTapped?
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: bloc.packages[globalIndex].plans.length,
                                itemBuilder: (context, index){
                                return Container(
                                  margin: EdgeInsets.only(top: 14),
                                  padding: EdgeInsets.symmetric
                                    (horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                      color:containerBgColor,
                                      borderRadius: BorderRadius
                                          .all(Radius.circular(12))
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width:24,
                                        height:24,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width:210,
                                            child: Text(
                                      '${bloc.packages[globalIndex].plans[index].title}',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Lato',
                                                color: textColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '${bloc.packages[globalIndex].plans[index].price}',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Lato',
                                              color: normalText,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                                },
                              )
                                  :Container(),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
            SizedBox(
              height: 30,
            )
            Container(
              height: 60,
              child: MainButton(
                color: primaryColor,
                child: Text(
                  "Book Appointment",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Lato',
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: () {

                },
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
  Future fetchRequests() async {
    Future.wait([
      bloc.fetchPakages(context),
    ]).then((value) {
      setState(() {
        isDataLoaded = true;
      });
    });
  }
}
