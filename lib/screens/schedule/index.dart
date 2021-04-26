import 'package:flutter/material.dart';
import 'package:hope_clinic/screens/book-appointment/index.dart';
import 'package:hope_clinic/screens/pain-report/index.dart';
import 'package:provider/provider.dart';
import 'package:hope_clinic/bloc/index.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:intl/intl.dart' show DateFormat;
class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  CalendarCarousel  _calendarCarouselNoHeader;
  DateTime _targetDateTime = DateTime.now();
  EventList<Event> _markedDateMap = new EventList<Event>();
  MainBloc mainBloc;
  String serverDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z";
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now().subtract(Duration(days: 100));
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
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
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    mainBloc = Provider.of<MainBloc>(context, listen:false);
  }
  @override
  Widget build(BuildContext context) {
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
        fontSize: 14,
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
      maxSelectedDate: _currentDate.add(Duration(days: 3600)),
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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 40.0, left: 20, right: 20, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "UPCOMING"
                              "\nAPPOINTMENT",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Lato',
                            color: greyColor,
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
                              color: textRed,
                              shape: BoxShape.circle
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "MISSED"
                              "\nAPPOINTMENT",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Lato',
                            color: greyColor,
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
                              color: customYellow,
                              shape: BoxShape.circle
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "PAST"
                              "\nAPPOINTMENT",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Lato',
                            color: greyColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
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
                Text(
                  "APPOINTMENTS",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'Lato',
                    color: greyColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 130,
                        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 17),
                        decoration: BoxDecoration(
                            color:lightGreen,
                            borderRadius: BorderRadius.all(Radius.circular(16))
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              mainBloc.daysLeftCount!=null?
                              "${mainBloc.daysLeftCount.count}"
                                  :0,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 32,
                                fontFamily: 'Lato',
                                color: primaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Upcoming\nAppointments",
                              textAlign: TextAlign.center,
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
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context)
                                  => PainReportPage()));
                        },
                        child: Container(
                          height: 130,
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          decoration: BoxDecoration(
                              color:primaryColor,
                              borderRadius: BorderRadius.all(Radius.circular(16))
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/icons/add_appointment.png',
                                height: 24,
                                width: 24,),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Book An\nAppointment",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Lato',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
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
  }
}
