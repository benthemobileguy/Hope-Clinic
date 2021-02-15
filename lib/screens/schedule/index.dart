import 'package:flutter/material.dart';
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
  CalendarCarousel  _calendarCarousel;
  DateTime _currentDate = DateTime(2019, 2, 3);
  DateTime _currentDate2 = DateTime(2019, 2, 3);
  String _currentMonth = DateFormat.yMMM().format(DateTime(2019, 2, 3));
  DateTime _targetDateTime = DateTime(2019, 2, 3);
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
  Widget build(BuildContext context) {

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
                  child: _calendarCarousel,
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
                    Container(
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
                            "5",
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
                    Spacer(),
                    Container(
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
