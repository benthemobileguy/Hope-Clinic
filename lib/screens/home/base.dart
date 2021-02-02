import 'package:flutter/material.dart';
import 'package:hope_clinic/screens/home/index.dart';
import 'package:hope_clinic/screens/profile/index.dart';
import 'package:hope_clinic/screens/schedule/index.dart';
import 'package:hope_clinic/screens/shop/index.dart';
import 'package:hope_clinic/utils/color.dart';

class Base extends StatefulWidget {
  final int currentIndex;
  Base({Key key, this.currentIndex}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _BaseState();
  }
}

class _BaseState extends State<Base> {
  int _currentIndex = 0;

  final scaffoldKeyBase = new GlobalKey<ScaffoldState>();
  ifNotNull() {
    if (widget.currentIndex != null) {
      setState(() {
        _currentIndex = widget.currentIndex;
      });
    }
  }

  @override
  void initState() {
    ifNotNull();

    super.initState();
  }

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext ctx) {
    List<Widget> _children = [
      new HomePage(),
      new SchedulePage(),
      new ProfilePage(),
      new ShopPage(),
    ];
    return new Scaffold(
      key: scaffoldKeyBase,
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedFontSize: 14.0,
        fixedColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                  color: _currentIndex == 0
                      ? HexColor("#FFF2E9") :
                  Colors.transparent,
                  shape: BoxShape.circle),
              child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child:ImageIcon(
                    AssetImage(
                      "images/icons/home.png",
                    ),
                    size: 25,
                  )
              ),
            ),
            title: Text(
              "Home",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'Lato',
                fontSize: 10,
              ),
            ),
          ),
          new BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                  color: _currentIndex == 1
                      ? HexColor("#FFF2E9") :
                  Colors.transparent,
                  shape: BoxShape.circle),
              child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child:ImageIcon(
                    AssetImage(
                      "images/icons/calendar.png",
                    ),
                    size: 25,
                  )
              ),
            ),
            title: Text(
              "Schedule",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'Lato',
                fontSize: 10,
              ),
            ),
          ),
          new BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                  color: _currentIndex == 2
                      ? HexColor("#FFF2E9") :
                  Colors.transparent,
                  shape: BoxShape.circle),
              child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child:ImageIcon(
                    AssetImage(
                      "images/icons/profile.png",
                    ),
                    size: 25,
                  )
              ),
            ),
            title: Text(
              "Profile",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'Lato',
                fontSize: 10,
              ),
            ),
          ),
          new BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                  color: _currentIndex == 3
                      ? HexColor("#FFF2E9") :
                  Colors.transparent,
                  shape: BoxShape.circle),
              child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child:ImageIcon(
                    AssetImage(
                      "images/icons/shop.png",
                    ),
                    size: 25,
                  )
              ),
            ),
            title: Text(
              "Shop",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'Lato',
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
      body: _children[_currentIndex],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
