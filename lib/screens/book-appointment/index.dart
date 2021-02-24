import 'package:flutter/material.dart';
import 'package:hope_clinic/bloc/index.dart';
import 'package:hope_clinic/shimmers/shimmer-list-view.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:hope_clinic/utils/color.dart';
import 'package:provider/provider.dart';
class BookAppointment extends StatefulWidget {
  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  bool isDataLoaded = false;
  bool isInitialised = false;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.
                        all(Radius.circular(12)),
                      side: BorderSide(color:
                      borderColor, width: 2)
                    ),
                    elevation: 2,
                    child: Container(
                      height: 90,

                    ),
                  ),
                ),
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
