import 'package:flutter/material.dart';
import 'package:hope_clinic/bloc/index.dart';
import 'package:hope_clinic/screens/message/index.dart';
import 'package:hope_clinic/screens/pain-report/index.dart';
import 'package:video_player/video_player.dart';
import 'package:hope_clinic/model/health-tips.dart';
import 'package:hope_clinic/screens/book-appointment/index.dart';
import 'package:hope_clinic/screens/components/main-button.dart';
import 'package:hope_clinic/screens/home/full-image-screen.dart';
import 'package:hope_clinic/utils/links.dart';
import 'package:hope_clinic/shimmers/shimmer-list-view.dart';
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
  int healthIndex = 0;
  bool isDataLoaded = false;
  bool isInitialised = false;
  HealthTips selectedHealthTip;
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    bloc = Provider.of<MainBloc>(context, listen:false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUser();
  }
  @override
  void dispose() {
    super.dispose();
    if(_controller!=null){
      _controller.dispose();
    }
  }
  @override
  Widget build(BuildContext context) {
    if (!isInitialised) {
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'images/icons/mail.png',
                                  height: 24,
                                  width: 24,
                                ),
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
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MessageScreen()));
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
                          height: 40,
                        ),
                        new Image.asset(
                          "images/logo.png",
                          height: 40,
                        ),
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
                    bloc.daysLeftCount != null
                        ? '${bloc.daysLeftCount.count} Days'
                        : "...",
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
                  "HEALTH TIPS",
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
                !isDataLoaded
                    ? ShimmerListView()
                    : Container(
                        height: 41,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: bloc.healthTips.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                setState(() {
                                  healthIndex = index;
                                  bloc.healthTips[0].tapped = false;
                                  if (selectedHealthTip != null) {
                                    selectedHealthTip.tapped = false;
                                  }
                                  bloc.healthTips[index].tapped =
                                      !bloc.healthTips[index].tapped;
                                  selectedHealthTip = bloc.healthTips[index];
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(12),
                                margin: EdgeInsets.only(right: 14),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    color: bloc.healthTips[index].tapped
                                        ? lightGreen
                                        : Colors.white),
                                child: Text(
                                  "${bloc.healthTips[index].segment}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Lato',
                                    color: bloc.healthTips[index].tapped
                                        ? primaryColor
                                        : greyColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                SizedBox(
                  height: 14,
                ),
                Container(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: bloc.healthTips != null
                        ? bloc.healthTips[healthIndex].files.length
                        : 0,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          if(!bloc.healthTips[healthIndex].files[index].contains(".jpg")){
                            if(_controller!=null){
                              _controller.dispose();
                            }
                            _controller = VideoPlayerController.network(
                                bloc.healthTips[healthIndex].files[index]);
                            _initializeVideoPlayerFuture = _controller.initialize();
                            _controller.setLooping(true);
                            _controller.setVolume(1.0);
                            isInitialised = true;
                          }
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              contentPadding: EdgeInsets.all(0.0),
                              content: GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context)
                                      => FullImageScreen(healthIndex: healthIndex,index:index)));
                                },
                                child:bloc.healthTips[healthIndex].files[index]
                                    .contains(".jpg")? Container(
                                  height: 400,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color:
                                      primaryColor.withOpacity(0.3),
                                          width: 2),
                                      image:
                                      DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                            bloc.healthTips[healthIndex].files[index].contains(".jpg")
                                            ?"${bloc.healthTips[healthIndex].files[index]}"
                                                :Links.imageThumbnailLink,
                                          ))),
                                ):FutureBuilder(
                                future: _initializeVideoPlayerFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done) {
                                    return Container(
                                        height: 400,
                                        width: double.infinity,
                                        child:
                                    VideoPlayer(_controller)
                                    );
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              ),
                              ),
                            ),
                          ).then((value) {

                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 16),
                          height: 160,
                          width: 130,
                          decoration: BoxDecoration(
                            color: primaryColor,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    bloc.healthTips[healthIndex].files[index].contains(".jpg")
                                        ?"${bloc.healthTips[healthIndex].files[index]}":Links.imageThumbnailLink,
                                  )),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              border:
                                  Border.all(color: primaryColor, width: 1)),
                        ),
                      );
                    },
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
                    Expanded(
                      child: Container(
                        height: 130,
                        padding:
                            EdgeInsets.symmetric(horizontal: 35, vertical: 17),
                        decoration: BoxDecoration(
                            color: lightGreen,
                            borderRadius: BorderRadius.all(Radius.circular(16))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              bloc.upcomingAppointment != null
                                  ? bloc.upcomingAppointment.count.toString()
                                  : "...",
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.all(Radius.circular(16))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/icons/add_appointment.png',
                                height: 24,
                                width: 24,
                              ),
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
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void fetchUser() async {
    prefManager.getUserData().then((value) {
      user = value;
      bloc.user = value;
    });
  }

  Future fetchRequests() async {
   await bloc.fetchNextAppointment(context);
    Future.wait([
      bloc.fetchUpcomingAppointment(context),
      bloc.fetchDaysLeftCount(context),
      bloc.fetchHealthTips(context)
    ]).then((value) {
      setState(() {
        isDataLoaded = true;

        ///show tips first item automatically
        setState(() {
          bloc.healthTips[0].tapped = true;
        });
      });
    });
  }
}
