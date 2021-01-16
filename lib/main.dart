import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  // Register all the models and services before the app starts

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runZoned<Future<Null>>(() async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      runApp(new MyApp());
    },);
  });
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainBloc>(
      create: (context) => MainBloc(),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: MaterialApp(
          title: 'Hope Chiropractic Health Clinic',
          theme: appTheme,
          initialRoute: '/',
          routes: routes,
          debugShowCheckedModeBanner: false,
          navigatorObservers: [],
        ),
      ),
    );
  }

}
