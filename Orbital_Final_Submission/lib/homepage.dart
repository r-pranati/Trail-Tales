import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './signup.dart';
import './signin.dart';
import './sgscape.dart';
import './userauth_provider.dart';
import './user_auth.dart';
import './dashboard.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of(context).auth;
    double swidth;
    double sheight;
    swidth = MediaQuery.of(context).size.width;
    sheight = MediaQuery.of(context).size.height;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool loggedIn = snapshot.hasData;
          return loggedIn ? DashboardScreen() : null; //MyWelcomePage();
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class MyWelcomePage extends StatefulWidget {
  @override
  _MyWelcomePageState createState() => _MyWelcomePageState();
}

class _MyWelcomePageState extends State<MyWelcomePage> {
  Future<bool> _onbackpressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You are going to exit the application!!'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double swidth;
    double sheight;
    swidth = MediaQuery.of(context).size.width;
    sheight = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: WillPopScope(
        onWillPop: _onbackpressed,
        child: SafeArea(
          child: Scaffold(
            body: Center(
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
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
                    ),
                  ),
                  Positioned(
                    top: sheight * 0.09,
                    left: swidth * 0.1,
                    right: swidth * 0.1,
                    child: Column(children: <Widget>[
                      TrailTalesText(),
                      BeginJourneyText(),
                    ]),
                  ),
                  Positioned(
                    top: sheight * 0.4,
                    left: swidth * 0.1,
                    right: swidth * 0.1,
                    child: Column(children: <Widget>[
                      EntryButton(1, 'sign-in'),
                      EntryButton(2, 'sign-up'),
                    ]),
                  ),
                  Positioned(
                      bottom: sheight * 0.07,
                      width: swidth * 1.01,
                      child: SafeArea(
                        child: SgScape(),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TrailTalesText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.all(sheight * 0.005),
      // color: Colors.white,
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 1, minHeight: 1), // here(
          child: Text(
            'Trail Tales',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF28495E),
              fontFamily: 'Rollcake',
              fontSize: swidth * 0.2,
            ),
          ),
        ),
      ),
    );
  }
}

class BeginJourneyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    return Container(
      // color: Colors.white,
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          '- begin your journey -',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF28495E),
            fontFamily: 'Gidolinya',
            fontSize: 0.9 * swidth * 0.1,
          ),
        ),
      ),
    );
  }
}

class EntryButton extends StatelessWidget {
  final int usage;
  final String answerText;
  EntryButton(this.usage, this.answerText);
  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.all(sheight * 0.02),
      width: swidth * 0.37,
      height: sheight * 0.07,
      child: RaisedButton(
        color: Color(0xFF28495E),
        elevation: 12,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(35.0)),
        highlightColor: Color(0xFF7C0E52),
        splashColor: Colors.tealAccent,
        onPressed: () {
          if (usage == 1) {
            Navigator.of(context).push(_createRoute());
          } else if (usage == 2) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SignUp(),
              ),
            );
          }
        },
        child: Text(
          answerText,
          style: TextStyle(
            fontSize: 0.9 * swidth * 0.09,
            fontFamily: 'Gidolinya',
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SignIn(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
