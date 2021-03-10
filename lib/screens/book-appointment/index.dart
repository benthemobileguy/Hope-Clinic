import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hope_clinic/bloc/index.dart';
import 'package:hope_clinic/model/plans.dart';
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
  PageController pageController = PageController();
  MainBloc bloc;
  int pagePos = 0;
  Plans selectedPlansData;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    bloc = Provider.of<MainBloc>(context);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    if (!isInitialised) {
    fetchRequests();
      isInitialised = true;
    }
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
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
        body: PageView(
          controller: pageController,
          onPageChanged: (pos){
            setState(() {
              pagePos = pos;
            });
          },
          physics: NeverScrollableScrollPhysics(),
         children: [
           //Page One
           Padding(
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
                     return GestureDetector(
                       onTap: (){
                         //single selection logic
                         setState(() {
                           if (selectedPlansData != null) {
                             selectedPlansData.isTapped =
                             false;
                           }
                           bloc.plans[index].isTapped =
                           !bloc.plans[index].isTapped;
                           selectedPlansData =
                           bloc.plans[index];
                         });
                       },
                       child: Container(
                         margin: EdgeInsets.only(bottom: 5),
                         child: Card(
                           shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.
                               all(Radius.circular(12)),
                               side: BorderSide(color:
                               borderColor, width: 1)
                           ),
                           child: Container(
                             padding: EdgeInsets.symmetric(horizontal: 16,vertical: 14),
                             child:  Row(
                               children: [
                                 Container(
                                   padding:EdgeInsets.all(3),
                                   decoration: BoxDecoration(
                                       border: Border.all(color: bloc.plans[index].isTapped?
                                       primaryColor:Colors.white, width: 1),
                                       shape: BoxShape.circle
                                   ),
                                   child: Container(

                                     width:24,
                                     height:24,
                                     decoration: BoxDecoration(
                                         border: Border.all(color: primaryColor, width: 1),
                                         color:bloc.plans[index].isTapped?primaryColor: Colors.white,
                                         shape: BoxShape.circle
                                     ),
                                   ),
                                 ),
                                 SizedBox(
                                   width: 20,
                                 ),
                                 Column(
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
                                       height: 10,
                                     ),
                                     Text(
                                       "NGN ${bloc.plans[index].price}",
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
                               ],
                             ),
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
                     onPressed: selectedPlansData !=null? () {
                       pageController.nextPage(
                           duration: Duration(milliseconds: 300),
                           curve: Curves.linear);
                     }:null,
                   ),
                 ),
                 SizedBox(
                   height: 30,
                 )
               ],
             ),
           ),
           Padding(
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

               ],
             ),
           ),
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


  Future<bool> onWillPop() {
   if(pagePos>0){
     pageController.previousPage(
         duration: Duration(milliseconds: 300),
         curve: Curves.linear);
   }else{
     Navigator.pop(context);
   }
  }
}
