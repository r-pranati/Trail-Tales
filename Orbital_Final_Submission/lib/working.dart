import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WorkingIt extends StatefulWidget {
  @override
  _WorkingItState createState() => _WorkingItState();
}

class _WorkingItState extends State<WorkingIt> {
  @override
  Widget build(BuildContext context) {
    double swidth;
    double sheight;
    swidth = MediaQuery.of(context).size.width;
    sheight = MediaQuery.of(context).size.height;
    return Container(
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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
                    // top: sheight * 0.1,
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      // color: Colors.white,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          'Page still under construction!\n Come back soon!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF28495E),
                            fontFamily: 'Gidolinya',
                            fontSize: 0.5 * swidth * 0.15,
                          ),
                        ),
                      ),
                    ),
                    Image.network(
                      'https://media.tenor.com/images/51da63cf8d8a702bbdefc3c21ba0af8a/tenor.gif',
                      width: swidth * 0.6,
                      height: sheight * 0.6,
                    ),
                    Iconbutback(),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Iconbutback extends StatelessWidget {
  Iconbutback();
  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.all(sheight * 0.02),
      height: sheight * 0.1,
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Ink(
            decoration: const ShapeDecoration(
              color: Color(0xFF28495E),
              shape: CircleBorder(),
            ),
            child: IconButton(
              icon: Icon(CupertinoIcons.back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
