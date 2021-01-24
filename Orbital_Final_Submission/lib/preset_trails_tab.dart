import 'package:Trailtales/dashboard.dart';
import 'package:Trailtales/homepage.dart';
import 'package:flutter/material.dart';
import './trail_screen.dart';
import './working.dart';

class PresetTrails extends StatelessWidget {
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

    final preset_trails = [
      'Botanic Gardens',
      'Bugis-Bras-Basah',
      'Bukit Timah',
      'Chinatown',
      'Fort Canning Park',
      'Little India',
      'Marina Bay Area',
      'Seletar',
      'Southern Ridges',
      'Tiong Bahru',
    ];
    final onTap = [
      // 'Botanic Gardens',

      () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TrailScreen('Botanic-Gardens'),
          ),
        );
        Navigator.of(context, rootNavigator: true).pop(context);
      },
      // 'Bugis-Bras-Basah',
      () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TrailScreen('bugis-trail'),
          ),
        );
        Navigator.of(context, rootNavigator: true).pop(context);
      },
      // 'Bukit Timah',
      () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TrailScreen('Bukit-Timah'),
          ),
        );
        Navigator.of(context, rootNavigator: true).pop(context);
      },
      // 'Chinatown',

      () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TrailScreen('China-Town'),
          ),
        );
        Navigator.of(context, rootNavigator: true).pop(context);
      },
      // 'Fort Canning Park',

      () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TrailScreen('Fort-Canning-Park'),
          ),
        );
        Navigator.of(context, rootNavigator: true).pop(context);
      },
      // 'Little India',
      () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TrailScreen('little-india'),
          ),
        );
        Navigator.of(context, rootNavigator: true).pop(context);
      },
      // 'Marina Bay Area',
      () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TrailScreen('Marina-Bay'),
          ),
        );
        Navigator.of(context, rootNavigator: true).pop(context);
      },
      // 'Seletar',
      () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TrailScreen('Seletar'),
          ),
        );
        Navigator.of(context, rootNavigator: true).pop(context);
      },

      // 'Southern Ridges',
      () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TrailScreen('southern-ridges'),
          ),
        );
        Navigator.of(context, rootNavigator: true).pop(context);
      },
      // 'Tiong Bahru',
      () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TrailScreen('Tiong-Bahru'),
          ),
        );
        Navigator.of(context, rootNavigator: true).pop(context);
      },
    ];
    final trail_img = [
      'assets/images/botanic_gardens.jpg',
      'assets/images/bugis.jpg',
      'assets/images/bukit_timah.jpg',
      'assets/images/chinatown.jpg',
      'assets/images/fort_canning.jpg',
      'assets/images/little_india.jpg',
      'assets/images/marina_bay.jpg',
      'assets/images/seletar.png',
      'assets/images/south_ridges.jpg',
      'assets/images/tiong_bahru.jpg',
    ];

    final reccomended_time = [
      '4 hours',
      '3 hours',
      '3.5 hours',
      '3 hours',
      '4 hours',
      '3 hours',
      '2.5 hours',
      '2.5 hours',
      '2 hours',
      '2 hours',
    ];
    final description = [
      'Botanic Gardens is a garden with a myriad of tourist spots to explore. It is home to the National Orchid Gardens which contains more than 1000 unique species and 2000 hybrids! ',
      'Explore Singapore\'s multi-racial society in this vibrant trail that combines modern with traditional. From Mosques, Hindu and Chinese temples, and Churches, to graffiti murals to world-class architecture... this trail has got it all. ',
      'Bukit Timah trail',
      'China Town',
      'Fort Canning',
      'A little area that reminds Indians of home.',
      'Marina Bay',
      'seletar',
      'Mountanous region of Singapore',
      'Tiong Bahru is known for its hidden kampung style shophouses and photogenic HDB flats.'
    ];

    return WillPopScope(
      onWillPop: _onbackpressed,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Positioned(
                //bottom: sheight * 0.86,
                top: sheight * 0.005,
                //left: swidth * 0.1,
                //right: swidth * 0.1,
                child: BackBut(),
              ),

              Positioned(
                top: sheight * 0.08,
                bottom: sheight * 0.002,
                child: Container(
                  width: swidth,
                  height: sheight,
                  child: ListView.builder(
                    itemCount: preset_trails.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 3,
                        child: ListTile(
                          leading: Image.asset(
                            trail_img[index],
                            fit: BoxFit.cover,
                            width: swidth * 0.3,
                          ),
                          title: Text(preset_trails[index]),
                          subtitle: Row(children: <Widget>[
                            Icon(
                              Icons.timer,
                              size: 20.0,
                            ),
                            Text(reccomended_time[index]),
                          ]),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            //////////// DIALOG BOX ////////////
                            Dialog trailDetails = Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                height: sheight * 0.5,
                                width: swidth * 0.7,
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      height: sheight * 0.43,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          description[index],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: sheight * 0.08,
                                      alignment: Alignment.bottomCenter,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF621351),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        ),
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          preset_trails[index],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: InkWell(
                                        onTap: onTap[index],
                                        // () {
                                        //   Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //       builder: (context) => TrailScreen(),
                                        //     ),
                                        //   );
                                        //   Navigator.of(context,
                                        //           rootNavigator: true)
                                        //       .pop(context);
                                        // },
                                        child: Container(
                                          width: double.infinity,
                                          height: sheight * 0.08,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF621351),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(12),
                                              bottomRight: Radius.circular(12),
                                            ),
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Start Trail!",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      // These values are based on trial & error method.
                                      // Not sure if it is responsive to screen size.
                                      alignment: Alignment(1.05, -1.05),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop(context);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    trailDetails);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Positioned(
              //   //bottom: sheight * 0.86,
              //   bottom: sheight * 0.95,
              //   //left: swidth * 0.1,
              //   //right: swidth * 0.1,
              //   child: BackBut(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackBut extends StatelessWidget {
  BackBut();
  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    return Container(
      height: sheight * 0.07,
      width: swidth,
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
