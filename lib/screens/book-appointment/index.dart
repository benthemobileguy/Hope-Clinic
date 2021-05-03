import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hope_clinic/model/date-slots.dart';
import 'package:mdi/mdi.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
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
  Timeslots selectedTimeslots;
  bool isDataLoaded = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int slotIndex = -1;

  List<String> times = ["8", "9", "10", "11", "12", "1", "2", "3", "4", "5"];
  StateSetter timeStateSetter;
  String serverDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z";
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now().subtract(Duration(days: 100));
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
    bloc = Provider.of<MainBloc>(context, listen:false);
  }
  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2019, 2, 10): [
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
      _calendarCarouselNoHeader = CalendarCarousel<Event>(
        pageScrollPhysics: NeverScrollableScrollPhysics(),
        onDayPressed: (DateTime date, List<Event> events) {
          this.setState(() {
            if(slotIndex != -1){
              bloc.dateSlots[0].timeslots[slotIndex].isTapped =false;
            }
            slotIndex = -1;
            _currentDate2 = date;
            print(date.toString().substring(0,10));
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
        // minSelectedDate: _currentDate.subtract(Duration(days: 1)),
        // maxSelectedDate: _currentDate.add(Duration(days: 3600)),
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
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            pagePos==0?"Book An Appointment":
            pagePos==1?"Payment Confirmation":
                pagePos==2?"Pick Your Preferred Day(s)"
                :"Scheduled Time Slots",
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
                 Center(
                   child: GestureDetector(
                     onTap: (){
                       showFullBottomSheet();
                     },
                     child: Container(
                       padding: EdgeInsets.all(6),
                       decoration: BoxDecoration(
                         borderRadius:BorderRadius.all(Radius.circular(8)),
                         color: primaryColor
                       ),
                       child: Text(
                         "See Hospital Account Details",
                         textAlign: TextAlign.start,
                         style: TextStyle(
                           fontSize: 14,
                           fontFamily: 'Lato',
                           color: Colors.white,
                           fontWeight: FontWeight.w700,
                         ),
                       ),
                     ),
                   ),
                 ),
                 SizedBox(
                   height: 30,
                 ),
                 Center(
                   child: Text(
                     "AVAILABLE PLANS FOR YOU",
                     textAlign: TextAlign.start,
                     style: TextStyle(
                       fontSize: 12,
                       fontFamily: 'Lato',
                       color: textColor,
                       fontWeight: FontWeight.w700,
                     ),
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
                                     Container(
                                       width:220,
                                       child: Text(
                                         bloc.plans[index].title,
                                         textAlign: TextAlign.start,
                                         style: TextStyle(
                                           fontSize: 16,
                                           fontFamily: 'Lato',
                                           color: normalTextBold,
                                           fontWeight: FontWeight.w700,
                                         ),
                                       ),
                                     ),
                                     SizedBox(
                                       height: 6,
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
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 SizedBox(
                   height: 30,
                 ),
                 Text(
                   "To continue scheduling. please make payment to the bank account and get confirmation",
                   textAlign: TextAlign.start,
                   style: TextStyle(
                     fontSize: 16,
                     fontFamily: 'Lato',
                     color: greyColor2,
                     fontWeight: FontWeight.w400,
                   ),
                 ),
                 SizedBox(
                   height: 20,
                 ),
                 Text(
                   "Account Name",
                   textAlign: TextAlign.center,
                   style: TextStyle(
                     fontSize: 12,
                     fontFamily: 'Lato',
                     color: greyColor2,
                     fontWeight: FontWeight.w700,
                   ),
                 ),
                 SizedBox(
                   height: 10,
                 ),
                 Text(
                   "HOPE Chiropractic Clinic",
                   textAlign: TextAlign.center,
                   style: TextStyle(
                     fontSize: 16,
                     fontFamily: 'Lato',
                     color: greyColor2,
                     fontWeight: FontWeight.w400,
                   ),
                 ),
                 SizedBox(
                   height: 20,
                 ),
                 Text(
                   "1. Access Bank",
                   textAlign: TextAlign.center,
                   style: TextStyle(
                     fontSize: 20,
                     fontFamily: 'Lato',
                     color: normalTexth1,
                     fontWeight: FontWeight.w700,
                   ),
                 ),
                 SizedBox(
                   height: 10,
                 ),
                 Container(
                   width: double.infinity,
                   padding: EdgeInsets.all(12),
                   decoration: BoxDecoration(
                       color: containerBgColor,
                       borderRadius: BorderRadius.all(Radius.circular(14))

                   ),
                   child: Text(
                     "0796900357",
                     textAlign: TextAlign.start,
                     style: TextStyle(
                       fontSize: 16,
                       fontFamily: 'Lato',
                       color: normalTextBold,
                       fontWeight: FontWeight.w600,
                     ),
                   ),
                 ),
                 SizedBox(
                   height: 10,
                 ),
                 GestureDetector(
                   onTap: (){
                     copyToClipboard("0796900357");
                   },
                   child: Container(
                     padding: EdgeInsets.all(12),
                     decoration: BoxDecoration(
                         color: lightGreen,
                         borderRadius: BorderRadius.all(Radius.circular(14))

                     ),
                     child: Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         Text(
                           "Copy acc. number",
                           textAlign: TextAlign.start,
                           style: TextStyle(
                             fontSize: 12,
                             fontFamily: 'Lato',
                             color: HexColor("#505050"),
                             fontWeight: FontWeight.w600,
                           ),
                         ),
                         SizedBox(
                           width: 16,
                         ),
                         new Icon(Icons.copy,size: 24,)
                       ],
                     ),
                   ),
                 ),
                 SizedBox(
                   height:10,
                 ),
                 Text(
                   "Or",
                   textAlign: TextAlign.start,
                   style: TextStyle(
                     fontSize: 16,
                     fontFamily: 'Lato',
                     color: HexColor("#787878"),
                     fontWeight: FontWeight.w600,
                   ),
                 ),
                 SizedBox(
                   height:10,
                 ),
                 Text(
                   "2. Access (Diamond) Bank",
                   textAlign: TextAlign.center,
                   style: TextStyle(
                     fontSize: 20,
                     fontFamily: 'Lato',
                     color: normalTexth1,
                     fontWeight: FontWeight.w700,
                   ),
                 ),
                 SizedBox(
                   height: 10,
                 ),
                 Container(
                   width: double.infinity,
                   padding: EdgeInsets.all(12),
                   decoration: BoxDecoration(
                       color: containerBgColor,
                       borderRadius: BorderRadius.all(Radius.circular(14))

                   ),
                   child: Text(
                     "0099797462",
                     textAlign: TextAlign.start,
                     style: TextStyle(
                       fontSize: 16,
                       fontFamily: 'Lato',
                       color: normalTextBold,
                       fontWeight: FontWeight.w600,
                     ),
                   ),
                 ),
                 SizedBox(
                   height: 10,
                 ),
                 GestureDetector(
                   onTap: (){
                     copyToClipboard("0099797462");
                   },
                   child: Container(
                     padding: EdgeInsets.all(12),
                     decoration: BoxDecoration(
                         color: lightGreen,
                         borderRadius: BorderRadius.all(Radius.circular(14))

                     ),
                     child: Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         Text(
                           "Copy acc. number",
                           textAlign: TextAlign.start,
                           style: TextStyle(
                             fontSize: 12,
                             fontFamily: 'Lato',
                             color: HexColor("#505050"),
                             fontWeight: FontWeight.w600,
                           ),
                         ),
                         SizedBox(
                           width: 16,
                         ),
                         new Icon(Icons.copy,size: 24,)
                       ],
                     ),
                   ),
                 ),
                 SizedBox(
                   height:40,
                 ),
                 Text(
                   "Kindly click here only if you have completed payment as required.",
                   textAlign: TextAlign.start,
                   style: TextStyle(
                     fontSize: 14,
                     height: 1.5,
                     fontFamily: 'Lato',
                     color: HexColor("#505050"),
                     fontWeight: FontWeight.w400,
                   ),
                 ),
                 SizedBox(
                   height:20,
                 ),
                 Container(
                   height: 60,
                   child: MainButton(
                     color: primaryColor,
                     child: Text(
                       "Payment Completed",
                       textAlign: TextAlign.start,
                       style: TextStyle(
                         fontSize: 14,
                         fontFamily: 'Lato',
                         color: Colors.white,
                         fontWeight: FontWeight.w700,
                       ),
                     ),
                     onPressed:() {
                       pageController.nextPage(
                           duration: Duration(milliseconds: 300),
                           curve: Curves.linear);
                     },
                   ),
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
                     onPressed:
                         isDataLoaded&&_markedDateMap!=null
                             &&
                     _markedDateMap.events.containsKey(_currentDate2)
                         ? () {
                     showTimeSlots();
                     }:null,
                   ),
                 ),
                 SizedBox(
                   height: 30,
                 ),
               ],
             ),
           ),
           //Page Four
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
        _markedDateMap.add(
            new DateFormat(serverDateFormat).parse(bloc.dateSlots[i].date),
            new Event(
              date: new DateFormat(serverDateFormat).parse(bloc.dateSlots[i].date),
              title: 'Event 5',
              icon: _eventIcon,
            ));
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

  void showTimeSlots() {
    // pageController.nextPage(
    //     duration: Duration(milliseconds: 300),
    //     curve: Curves.linear);
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft:
          Radius.circular(40),
              topRight: Radius.circular(40)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(

            builder: (BuildContext context, StateSetter setState) {
              timeStateSetter = setState;
              return Container(
                padding: EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Select Time Slots",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Lato',
                            color: HexColor("#505050"),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            child: new Icon(
                              Mdi.close,
                              color: HexColor("#505050"),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                     DateFormat.yMMMMEEEEd().format(_currentDate2),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Lato',
                        color: HexColor("#505050"),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 55,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: times.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 55,
                            width: 70,
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.only(right: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              border: Border.all(width: 1,color: Color.fromRGBO(3, 85, 71, 0.3)),

                            ),
                            child:  Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  times[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Lato',
                                    color: normalTextBold,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0, bottom: 3),
                                  child: Text(
                                    'AM',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Lato',
                                      color: HexColor('#787878'),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 60,
                      width:double.infinity,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: bloc.dateSlots[0].timeslots.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                          onTap: (){
                            setState(() {
                              slotIndex = index;
                              if (selectedTimeslots != null) {
                                selectedTimeslots.isTapped =
                                false;
                              }
                              bloc.dateSlots[0].timeslots[index].isTapped =
                              !bloc.dateSlots[0].timeslots[index].isTapped;
                              selectedTimeslots =
                              bloc.dateSlots[0].timeslots[index];
                            });
                          },
                            child: Container(
                              margin: EdgeInsets.only(right: 14),
                              height: 60,
                              width: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: containerBgColor
                              ),
                              child:   Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width:24,
                                    height:24,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: !bloc.dateSlots[0].timeslots[index].isTapped?Colors.white:primaryColor
                                    ),
                                  ),
                                  SizedBox(
                                    width: 14,
                                  ),
                                  Text(
                                    '${bloc.dateSlots[0].timeslots[index].startTime} '
                                        '- ${bloc.dateSlots[0].timeslots[index].endTime}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14.5,
                                      fontFamily: 'Lato',
                                      color: normalText,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );

                        },
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 60,
                            child: MainButton(
                              color: redBg,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  new Icon(Mdi.close,
                                    color: textRed,size: 12,),
                                  SizedBox(
                                    width: 14,
                                  ),
                                  Text(
                                    "Cancel",
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
                              onPressed: slotIndex !=-1? () {
                               Navigator.pop(context);
                              }:null,
                            ),
                          ),
                        ),
                        SizedBox(width: 12,),
                        Expanded(
                          child: Container(
                            height: 60,
                            child: MainButton(
                              color: primaryColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  new Icon(Mdi.check,
                                    color: Colors.white,size: 12,),
                                  SizedBox(
                                    width: 14,
                                  ),
                                  Text(
                                    "Confirm",
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
                              onPressed: slotIndex !=-1? () {
                             Navigator.pop(context);
                             showConfirmBottomSheet();
                              }:null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
  });

  }

  void showConfirmBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft:
          Radius.circular(40),
              topRight: Radius.circular(40)),
        ),
      isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                return Container(
                  padding: EdgeInsets.all(14),
                 child: Column(
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     Row(
                        children: [
                          Text(
                            "Appointment",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Lato',
                              color: HexColor("#505050"),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              child: new Icon(
                                Mdi.close,
                                color: HexColor("#505050"),
                              ),
                            ),
                          )
                        ],
                      ),
                     SizedBox(
                       height: 20,
                     ),
                     Text(
                       "Great, your schedule calendar has also been sent to your mail. We will contact you shortly",
                       textAlign: TextAlign.center,
                       style: TextStyle(
                         fontSize: 14,
                         fontFamily: 'Lato',
                         color: HexColor("#505050"),
                         fontWeight: FontWeight.w700,
                       ),
                     ),
                     SizedBox(
                       height: 10,
                     ),
                   ],
                 ),
                );
              });
        });
  }

  void showFullBottomSheet() {
    showBarModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "To continue scheduling. please make payment to the bank account and get confirmation",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Lato',
                color: greyColor2,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Account Name",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Lato',
                color: greyColor2,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "HOPE Chiropractic Clinic",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Lato',
                color: greyColor2,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "1. Access Bank",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Lato',
                color: normalTexth1,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: containerBgColor,
                borderRadius: BorderRadius.all(Radius.circular(14))
                
              ),
              child: Text(
                "0796900357",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                  color: normalTextBold,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: (){
                copyToClipboard("0796900357");
              },
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: lightGreen,
                    borderRadius: BorderRadius.all(Radius.circular(14))

                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Copy acc. number",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Lato',
                        color: HexColor("#505050"),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    new Icon(Icons.copy,size: 24,)
                  ],
                ),
              ),
            ),
            SizedBox(
              height:10,
            ),
            Text(
              "Or",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Lato',
                color: HexColor("#787878"),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height:10,
            ),
            Text(
              "2. Access (Diamond) Bank",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Lato',
                color: normalTexth1,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: containerBgColor,
                  borderRadius: BorderRadius.all(Radius.circular(14))

              ),
              child: Text(
                "0099797462",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                  color: normalTextBold,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: (){
                copyToClipboard("0099797462");
              },
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: lightGreen,
                    borderRadius: BorderRadius.all(Radius.circular(14))

                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Copy acc. number",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Lato',
                        color: HexColor("#505050"),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    new Icon(Icons.copy,size: 24,)
                  ],
                ),
              ),
            ),
            SizedBox(
              height:10,
            ),
          ],
        ),
        );
      },
    );
  }

  void copyToClipboard(String text) {
    Clipboard.setData(new ClipboardData(text: text)).then((_){
    AlertManager.showToast("Account number copied to clipboard");
    });
  }
}
