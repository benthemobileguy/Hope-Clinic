import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hope_clinic/bloc/index.dart';
import 'package:hope_clinic/model/plans.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:hope_clinic/screens/components/main-button.dart';
import 'package:hope_clinic/shimmers/shimmer-list-view.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:hope_clinic/utils/color.dart';
import 'package:provider/provider.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;
class BookAppointment extends StatefulWidget {
  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  bool isDataLoaded = false;
  DateTime _currentDate = DateTime(2019, 2, 3);
  DateTime _currentDate2 = DateTime(2019, 2, 3);
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: textColor, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );
  bool isInitialised = false;
  CalendarCarousel  _calendarCarousel;
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
      EventList<Event> _markedDateMap = new EventList<Event>(
        events: {
          new DateTime(2019, 2, 10): [
            new Event(
              date: new DateTime(2019, 2, 10),
              title: 'Event 1',
              icon: _eventIcon,
              dot: Container(
                margin: EdgeInsets.symmetric(horizontal: 1.0),
                color: textColor,
                height: 5.0,
                width: 5.0,
              ),
            ),
            new Event(
              date: new DateTime(2019, 2, 10),
              title: 'Event 2',
              icon: _eventIcon,
            ),
            new Event(
              date: new DateTime(2019, 2, 10),
              title: 'Event 3',
              icon: _eventIcon,
            ),
          ],
        },
      );
      _calendarCarousel = CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          this.setState(() => _currentDate = date);
          events.forEach((event) => print(event.title));
        },
        weekendTextStyle: TextStyle(
          color: textColor,
        ),
        thisMonthDayBorderColor: Colors.grey,
//          weekDays: null, /// for pass null when you do not want to render weekDays
        headerText: 'December 2016',
        weekFormat: false,
        markedDatesMap: _markedDateMap,
        height: 370.0,
        selectedDateTime: _currentDate2,
        showIconBehindDayText: true,
//          daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
        customGridViewPhysics: NeverScrollableScrollPhysics(),
        markedDateShowIcon: true,
        markedDateIconMaxShown: 2,
        selectedDayTextStyle: TextStyle(
          color: Colors.yellow,
        ),
        todayTextStyle: TextStyle(
          color: textColor,
        ),
        markedDateIconBuilder: (event) {
          return event.icon;
        },
        minSelectedDate: _currentDate.subtract(Duration(days: 360)),
        maxSelectedDate: _currentDate.add(Duration(days: 360)),
        todayButtonColor: Colors.transparent,
        todayBorderColor: Colors.green,
        markedDateMoreShowTotal:
        true, // null for not showing hidden events indicator
//          markedDateIconMargin: 9,
//          markedDateIconOffset: 3,
      );
    fetchRequests();
      isInitialised = true;
    }
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            pagePos==0?"Book An Appointment":pagePos==1?"Pick Your Preferred Day(s)":"Scheduled Time Slots",
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
            onWillPop();
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
           //Page Two
           Padding(
             padding: const EdgeInsets
                 .symmetric(horizontal: 14),
             child: ListView(
               children: [
                 SizedBox(
                   height: 30,
                 ),
                 Row(
                   children: [
                     Spacer(),
                     Column(
                       children: [
                         Container(
                           width: 8,
                           height: 8,
                           decoration: BoxDecoration(
                               border: Border.all(color: primaryColor, width: 2),
                               shape: BoxShape.circle
                           ),
                         ),
                         SizedBox(
                           height: 5,
                         ),
                         Text(
                           "AVAILABLE",
                           textAlign: TextAlign.center,
                           style: TextStyle(
                             fontSize: 12,
                             fontFamily: 'Lato',
                             color: primaryColor,
                             fontWeight: FontWeight.w700,
                           ),
                         ),
                       ],
                     ),
                     Spacer(),
                     Column(
                       children: [
                         Container(
                           width: 8,
                           height: 8,
                           decoration: BoxDecoration(
                               border: Border.all(color: textRed, width: 2),
                               shape: BoxShape.circle
                           ),
                         ),
                         SizedBox(
                           height: 5,
                         ),
                         Text(
                           "UNAVAILABLE",
                           textAlign: TextAlign.center,
                           style: TextStyle(
                             fontSize: 12,
                             fontFamily: 'Lato',
                             color: textRed,
                             fontWeight: FontWeight.w700,
                           ),
                         ),
                       ],
                     ),
                     Spacer(),
                   ],
                 ),
                 SizedBox(
                   height: 30,
                 ),
                 Container(
                   child: _calendarCarousel,
                 ), //
                 SizedBox(
                   height: 30,
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
                 ),
               ],
             ),
           ),
           //Page Three
           Padding(
             padding: const EdgeInsets
                 .symmetric(horizontal: 14),
             child: ListView(
               children: [
                 SizedBox(
                   height: 20,
                 ),
                 Row(
                   children: [
                     Container(
                       padding: EdgeInsets.all(12),
                       decoration: BoxDecoration(
                         color: accentColor,
                         shape: BoxShape.circle
                       ),
                       child: Text(
                         "1",
                         textAlign: TextAlign.center,
                         style: TextStyle(
                           fontSize: 18,
                           fontFamily: 'Lato',
                           color: primaryColor,
                           fontWeight: FontWeight.w700,
                         ),
                       ),
                     ),
                     SizedBox(
                       width: 10,
                     ),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           "Tuesday, January 10th, 2021",
                           textAlign: TextAlign.center,
                           style: TextStyle(
                             fontSize: 16,
                             fontFamily: 'Lato',
                             color: HexColor("#505050"),
                             fontWeight: FontWeight.w400,
                           ),
                         ),
                         Text(
                           "10 AM - 11 AM",
                           textAlign: TextAlign.center,
                           style: TextStyle(
                             fontSize: 16,
                             fontFamily: 'Lato',
                             color: HexColor("#505050"),
                             fontWeight: FontWeight.w700,
                           ),
                         ),
                       ],
                     ),
                   ],
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
