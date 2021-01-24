import 'dart:ffi';
import 'package:Trailtales/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:Trailtales/homepage.dart';
import 'package:numberpicker/numberpicker.dart';
import './customtrailscreen.dart';

class CustomTrails extends StatefulWidget {
  _CustomTrailsState createState() => _CustomTrailsState();
}

class _CustomTrailsState extends State<CustomTrails> {
  Item selectedUser;
  int _currentValue = 100;

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    Future<bool> _onbackpressed() {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Are you sure?'),
              content: Text('You are going to Log out of the application!!'),
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
                    //Navigator.of(context).pop(true);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyWelcomePage(),
                      ),
                      ModalRoute.withName('/'),
                    );
                  },
                ),
              ],
            );
          });
    }

    return WillPopScope(
      onWillPop: _onbackpressed,
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            Scaffold(
                body: new Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new NumberPicker.integer(
                      initialValue: _currentValue,
                      minValue: 0,
                      maxValue: 500,
                      onChanged: (newValue) =>
                          setState(() => _currentValue = newValue)),
                  new Text("Trail time in minutes: $_currentValue"),
                ],
              ),
            )),
            Positioned(
              bottom: sheight * 0.8,
              child: BackBut(),
            ),
            Positioned(
              bottom: sheight * 0.1,
              left: swidth * 0.1,
              right: swidth * 0.1,
              child: Startbutton(_currentValue),
            ),
          ],
        ),
      ),
    );
  }
}

class Item {
  const Item(this.hours, this.icon);
  final String hours;
  final Icon icon;
}

class BackBut extends StatelessWidget {
  BackBut();
  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    return Container(
      height: sheight * 0.07,
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Ink(
            decoration: const ShapeDecoration(
              color: Color(0xFF621351),
              shape: ContinuousRectangleBorder(),
            ),
            child: SizedBox(
              width: swidth,
              child: FlatButton(
                child: Icon(
                  IconData(58134, fontFamily: 'MaterialIcons'),
                  color: Colors.white,
                ),
                //iconSize: 30,
                color: Colors.transparent,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DashboardScreen(),
                    ),
                  );
                  print("back to current location map");
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Startbutton extends StatelessWidget {
  final int currentValue;
  Startbutton(this.currentValue);
  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.all(sheight * 0.02),
      width: swidth * 0.6,
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CustomTrailScreen('custom', currentValue),
            ),
          );
        },
        child: Text(
          'Begin Trail',
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