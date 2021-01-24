import 'package:Trailtales/homepage.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './userauth_provider.dart';
import './user_auth.dart';
import './sgscape.dart';

void main() {
  runApp(new MaterialApp(
    home: new SplashScreenPage(),
  ));
}

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => new _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 4,
      navigateAfterSeconds: new MyApp(),
      title: new Text(
        'Begin Your Journey',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: Image.asset(
        "assets/images/logo.png",
        width: 400,
        height: 400,
      ),
      gradientBackground: new LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF75B5E7),
          Color(0xFF7AD5E3),
          Color(0xFFEBC9C6),
          Color(0xFFF3E7E7),
        ],
        stops: [0, 0.44, 0.77, 1],
      ),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: () => print("Trail Tales"),
      loaderColor: Colors.red,
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0xFF75B5E7),
        systemNavigationBarColor: Color(0xFFF3E7E7),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return Provider(
      auth: Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: MyWelcomePage(),
      ),
    );
  }
}
