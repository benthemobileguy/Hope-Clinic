import 'package:flutter/material.dart';

class Base extends StatefulWidget {
  final int currentIndex;
  Base({Key key, this.currentIndex}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _BaseState();
  }
}

class _BaseState extends State<Base> {
  SizeConfig _sizeConfig = SizeConfig();
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
      new WalletScreen(),
      new TripsPage(),
      new ReferralPage(),
      new ProfilePage()
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
                      "assets/images/home.png",
                    ),
                    size: 25,
                  )
              ),
            ),
            title: Text(
              "Home",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
                fontSize: _sizeConfig.textSize(
                  context,
                  1.7,
                ),
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
                      "assets/images/wallet.png",
                    ),
                    size: 25,
                  )
              ),
            ),
            title: Text(
              "Wallet",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
                fontSize: _sizeConfig.textSize(
                  context,
                  1.7,
                ),
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
                      "assets/images/trips.png",
                    ),
                    size: 25,
                  )
              ),
            ),
            title: Text(
              "Trips",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
                fontSize: _sizeConfig.textSize(
                  context,
                  1.7,
                ),
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
                      "assets/images/referral.png",
                    ),
                    size: 25,
                  )
              ),
            ),
            title: Text(
              "Referral",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
                fontSize: _sizeConfig.textSize(
                  context,
                  1.7,
                ),
              ),
            ),
          ),
          new BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ImageDisplay(
                icon: Icons.person,
                iconHeight: 20.0,
                profilePicture: null,
                height: _sizeConfig.heightMargin(context, 2.0),
              ),
            ),
            title: Text(
              "Profile",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
                fontSize: _sizeConfig.textSize(
                  context,
                  1.7,
                ),
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
