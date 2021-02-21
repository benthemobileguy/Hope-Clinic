import 'package:flutter/material.dart';
import 'package:hope_clinic/bloc/index.dart';
import 'package:hope_clinic/screens/components/main-button.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:hope_clinic/utils/global-variables.dart';
import 'package:hope_clinic/utils/pref-manager.dart';
import 'package:provider/provider.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PrefManager prefManager = PrefManager();
  MainBloc bloc;
  bool isInitialised = false;
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
    fetchUser();
  }
  @override
  Widget build(BuildContext context) {
    if(!isInitialised){
      fetchRequests();
      isInitialised = true;
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "DOCTOR INFO",
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
                        Text(
                          "Dr. Onuoha\nOkeigwe",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Lato',
                            color: primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Chiropractor",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Lato',
                            color: textColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 60,
                          width: 155,
                          child: MainButton(
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                             Image.asset(
                               'images/icons/mail.png',
                               height: 24,
                               width: 24,),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Message",
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
                            color: primaryColor,
                            onPressed: (){

                            },
                          ),
                        ),
                        Text(
                          "Message",
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
                    Spacer(),
                    Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        new Image.asset("images/man_smiling.png",
                          height: 204,),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "NEXT APPOINTMENT IN",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Lato',
                      color: greyColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "3 Days",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Lato',
                      color: primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
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

  void fetchUser() async{
   prefManager.getUserData().then((value){
     user = value;
    bloc.user = value;
   });
  }

 Future fetchRequests() async{
    Future.wait([
      bloc.fetchNextAppointment(context),
      bloc.fetchUpcomingAppointment(context),
      bloc.fetchDaysLeftCount(context),
      bloc.fetchHealthTips(context)
    ]);
  }
}
