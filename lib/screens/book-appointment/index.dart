import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hope_clinic/bloc/index.dart';
import 'package:hope_clinic/model/plans.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:hope_clinic/screens/components/main-button.dart';
import 'package:hope_clinic/shimmers/shimmer-list-view.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:hope_clinic/utils/alert-manager.dart';
import 'package:hope_clinic/utils/color.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;

class BookAppointment extends StatefulWidget {
  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  bool isDataLoaded = false;
  String serverDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z";
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.lime,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: textColor, width: 6.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );
  bool isInitialised = false;
  CalendarCarousel  _calendarCarouselNoHeader;
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
  EventList<Event> _markedDateMap = new EventList<Event>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(DateTime.now());


  }
  @override
  Widget build(BuildContext context) {
    _markedDateMap = new EventList<Event>(
        events: {
          new DateTime(2021, 3, 19): [
            new Event(
              date: new DateTime(2021, 3, 19),
              title: 'Event 1',
              icon: _eventIcon,
            ),
          ],
          new DateTime(2021, 3, 22): [
            new Event(
              date: new DateTime(2021, 3, 22),
              title: 'Event 1',
              icon: _eventIcon,
            ),
          ],
        },
      );
      _calendarCarouselNoHeader = CalendarCarousel<Event>(
        pageScrollPhysics: NeverScrollableScrollPhysics(),
        onDayPressed: (DateTime date, List<Event> events) {
          this.setState(() {
            _currentDate2 = date;
            print(date);
          });
          events.forEach((event) => print(event.title));
        },
        markedDateShowIcon: true,
        headerTextStyle: TextStyle(
          fontSize: 16,
          fontFamily: 'Lato',
          color: normalText,
          fontWeight: FontWeight.w700,
        ),
        weekdayTextStyle: TextStyle(
          fontSize: 16,
          fontFamily: 'Lato',
          color: normalText,
          fontWeight: FontWeight.w800,
        ),
        iconColor: normalText,
        markedDateCustomTextStyle: TextStyle(
          fontSize: 16,
          fontFamily: 'Lato',
          color: normalText,
          fontWeight: FontWeight.w700,
        ),
        todayTextStyle: TextStyle(
          fontSize: 16,
          fontFamily: 'Lato',
          color: normalText,
          fontWeight: FontWeight.w700,
        ),
        todayButtonColor: Colors.white,
        weekDayMargin: EdgeInsets.all(5),
        selectedDayBorderColor: primaryColor,
        selectedDayButtonColor: primaryColor,
        selectedDayTextStyle:  TextStyle(
          fontSize: 16,
          fontFamily: 'Lato',
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
        markedDateCustomShapeBorder: CircleBorder(
          side: BorderSide(color: primaryColor, width: 2)
        ),
        daysHaveCircularBorder: true,
       // showOnlyCurrentMonthDate: true,
        weekendTextStyle: TextStyle(
          fontSize: 16,
          fontFamily: 'Lato',
          color: normalText,
          fontWeight: FontWeight.w800,
        ),
        thisMonthDayBorderColor: textRed,
        weekFormat: false,
//      firstDayOfWeek: 4,
        markedDatesMap: _markedDateMap,
        height: 420.0,
        selectedDateTime: _currentDate2,
        targetDateTime: _targetDateTime,
        customGridViewPhysics: NeverScrollableScrollPhysics(),
        daysTextStyle: TextStyle(
          fontSize: 16,
          fontFamily: 'Lato',
          color: normalText,
          fontWeight: FontWeight.w700,
        ),
        minSelectedDate: _currentDate.subtract(Duration(days: 1)),
        maxSelectedDate: _currentDate.add(Duration(days: 360)),
        inactiveDaysTextStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
        onCalendarChanged: (DateTime date) {
          this.setState(() {
            _targetDateTime = date;
            _currentMonth = DateFormat.yMMM().format(_targetDateTime);
          });
        },

        onDayLongPressed: (DateTime date) {
          print('long pressed date $date');
        },
      );
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
                   child: _calendarCarouselNoHeader,
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
             child: Column(
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
                         SizedBox(
                           height: 6,
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
                 SizedBox(
                   height: 16,
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
                         "2",
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
                           "Friday, January 13th, 2021",
                           textAlign: TextAlign.center,
                           style: TextStyle(
                             fontSize: 16,
                             fontFamily: 'Lato',
                             color: HexColor("#505050"),
                             fontWeight: FontWeight.w400,
                           ),
                         ),
                         SizedBox(
                           height: 6,
                         ),
                         Text(
                           "12 AM - 17 AM",
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
                Spacer(),
                 Container(
                   height: 60,
                   child: MainButton(
                     color: primaryColor,
                     child: Text(
                       "Schedule",
                       textAlign: TextAlign.start,
                       style: TextStyle(
                         fontSize: 14,
                         fontFamily: 'Lato',
                         color: Colors.white,
                         fontWeight: FontWeight.w700,
                       ),
                     ),
                     onPressed: selectedPlansData !=null? () {
                       Navigator.pop(context);
                       AlertManager.showToast("Appointment Scheduled");
                     }:null,
                   ),
                 ),
                 SizedBox(
                   height: 20,
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
    Future.wait([
      bloc.fetchPlans(context),
      bloc.fetchDateSlots(context)

    ]).then((value) {
      setState(() {
        isDataLoaded = true;
      });
      for (int i =0; i < bloc.dateSlots.length; i++){
        setState(() {
          // _markedDateMap.add(
          //     new DateFormat(serverDateFormat).parse(bloc.dateSlots[i].date),
          //     new Event(
          //       date: new DateFormat(serverDateFormat).parse(bloc.dateSlots[i].date),
          //       title: 'Event 5',
          //       icon: _eventIcon,
          //     ));
        });
      };

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
