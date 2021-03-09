import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hope_clinic/bloc/index.dart';
import 'package:hope_clinic/screens/components/main-button.dart';
import 'package:hope_clinic/shimmers/shimmer-list-view.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:provider/provider.dart';

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
              "AVAILABLE PLANS FOR YOU",
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
                  itemCount: bloc.plans.length,
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
                          padding: EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 10),
                          child:  Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bloc.plans[index].title,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Lato',
                                  color: normalTextBold,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(

                              ),
                              Text(
                                "NGN ${bloc.plans[index].price}",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Lato',
                                  color: textColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
            Container(
              height: 60,
              child: MainButton(
                color: primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Image.asset('images/icons/bookmark.png',
                      height: 16,
                      width: 10,),
                    SizedBox(
                      width: 14,
                    ),
                    Text(
                      "Book Appointment",
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

  void fetchRequests() {
 bloc.fetchPlans(context).then((value){
   setState(() {
     isDataLoaded = true;
   });
 });
  }

}
