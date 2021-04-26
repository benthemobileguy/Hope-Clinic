import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hope_clinic/bloc/index.dart';
import 'package:hope_clinic/screens/splash-screen.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:provider/provider.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Register all the models and services before the app starts

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runZoned<Future<Null>>(() async {
      runApp(new MyApp());
    },);
  });
}

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainBloc>(
      create: (context) => MainBloc(),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: MaterialApp(
          title: 'Hope Chiropratic Health Clinic',
          theme: appTheme,
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
          navigatorObservers: [],
        ),
      ),
    );
  }
}
