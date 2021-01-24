import 'package:Trailtales/camera_screen.dart';
import 'package:Trailtales/preset_trails_tab.dart';
import 'package:Trailtales/quiz.dart';
import 'package:Trailtales/quiz_question.dart';
import 'package:Trailtales/sgscape.dart';
import 'package:Trailtales/trail_tabs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './music.dart';
import './secrets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import './quiz.dart';
import './quiz_question.dart';
import './working.dart';
import 'dashboard.dart';



class TrailScreen extends StatefulWidget {
  final String trailname;
  TrailScreen(this.trailname, {Key key}) : super(key: key);
  //final QuestionModel questionModel;
  //TrailScreen(this.questionModel);

  @override
  _TrailScreenState createState() => _TrailScreenState();
}

class _TrailScreenState extends State<TrailScreen> {
  var iter = -1;
  var fs = Firestore.instance;
  List<Map<dynamic, dynamic>> location = List<Map<dynamic, dynamic>>();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;
  Set<Marker> markers = {};

  PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  Map dogBoy = {};
  getposts(List<Map> Location1, String trailpath) async {
    await fs.collection('Preset Trail').getDocuments().then((data) {
      data.documents.forEach((doc) {
        // setState(() {
        int i = 0;
        int num;
        print('hi print the doc data');
        // print(dogBoy);
        print(doc.data[trailpath]);
        // print(doc.data['bugis-trail'][0].runtimeType);
        // print(doc.data['bugis-trail'].length);
        int len = doc.data[trailpath].length;
        for (num = 0; num < len; num++) {
          print("CAN YOU PLEASE WORK");
          print(dogBoy.runtimeType);
          dogBoy['id'] = doc.data[trailpath][num]['id'];
          dogBoy['name'] = doc.data[trailpath][num]['name'];
          dogBoy['lat'] = doc.data[trailpath][num]['lat'];
          dogBoy['lng'] = doc.data[trailpath][num]['lng'];
          dogBoy['song'] = doc.data[trailpath][num]['song'];
          dogBoy['question'] = doc.data[trailpath][num]['question'];
          dogBoy['option1'] = doc.data[trailpath][num]['option1'];
          dogBoy['option2'] = doc.data[trailpath][num]['option2'];
          dogBoy['option3'] = doc.data[trailpath][num]['option3'];
          dogBoy['option4'] = doc.data[trailpath][num]['option4'];
          print(dogBoy);
          Location1.add(dogBoy);
          dogBoy = {};
          print(Location1);
          print("\n\n");
          // print(_locations[num]['id']);
          // num++;
        }
        print("CAN YOU PLEASE WORK");
        print(Location1);
        // print(Location1.runtimeType);
        // },
        // );
      });
    });
  }

  Position _currentPosition;
  GoogleMapController mapController;
  CameraPosition _initialLocation = CameraPosition(
    target: LatLng(1.3, 1),
  );
  final Geolocator _geolocator = Geolocator();
  String songname = 'music/wait.mp3';

  _markerplace(List<Map> Location1) async {
    print('Namaste!');
    Position startCoordinates;
    if (iter < 0) {
      // where = 'Current location ';
      startCoordinates = Position(
        latitude: _currentPosition.latitude,
        longitude: _currentPosition.longitude,
      );
    } else {
      // where = _locations[iter + 1]['name'];
      startCoordinates = Position(
          latitude: Location1[iter]['lat'], longitude: Location1[iter]['lng']);
    }
    //print('$startCoordinates');
    Position destinationCoordinates = Position(
        latitude: Location1[iter + 1]['lat'],
        longitude: Location1[iter + 1]['lng']);

    Marker startMarker = Marker(
      markerId: MarkerId('$startCoordinates'),
      position: LatLng(
        startCoordinates.latitude,
        startCoordinates.longitude,
      ),
      icon: BitmapDescriptor.defaultMarker,
    );
    Marker destinationMarker = Marker(
        markerId: MarkerId('$destinationCoordinates'),
        position: LatLng(
          destinationCoordinates.latitude,
          destinationCoordinates.longitude,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure));
    markers.add(startMarker);
    markers.add(destinationMarker);
    print(markers);
    double distanceInMeters = await Geolocator().bearingBetween(
      startCoordinates.latitude,
      startCoordinates.longitude,
      destinationCoordinates.latitude,
      destinationCoordinates.longitude,
    );
    if (distanceInMeters <= 377) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(Location1[iter]['lat'], Location1[iter]['lng']),
            zoom: 16.2)),
      );
    } else {
      Position _northeastCoordinates;
      Position _southwestCoordinates;
      if (startCoordinates.latitude <= destinationCoordinates.latitude) {
        _southwestCoordinates = startCoordinates;
        _northeastCoordinates = destinationCoordinates;
      } else {
        _southwestCoordinates = destinationCoordinates;
        _northeastCoordinates = startCoordinates;
      }
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(
              _northeastCoordinates.latitude,
              _northeastCoordinates.longitude,
            ),
            southwest: LatLng(
              _southwestCoordinates.latitude,
              _southwestCoordinates.longitude,
            ),
          ),
          100.0,
        ),
      );
    }

    // mapController.animateCamera(
    //   CameraUpdate.newCameraPosition(CameraPosition(
    //       target: LatLng(_locations[iter]['lat'], _locations[iter]['lng']),
    //       zoom: 17.0)),
    // );

    await _createPolylines(startCoordinates, destinationCoordinates);
  }


  _getCurrentLocation() async {
    await _geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) async {
      setState(() {
        // Store the position in the variable
        _currentPosition = position;

        print('CURRENT POS: $_currentPosition');

        // For moving the camera to current location
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
    }).catchError((e) {
      print(e);
    });
  }

// Create the polylines for showing the route between two places
  _createPolylines(Position start, Position destination) async {
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Secrets.API_KEY, // Google Maps API Key
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.walking,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    setState(() {
      PolylineId id = PolylineId('poly');
      Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.red,
        points: polylineCoordinates,
        width: 3,
      );
      polylines[id] = polyline;
    });

  }

// QUIZ_PLAY_TILE
  int _correct = 0;

  String optionSelected = '';

  QuestionModel getQuestionModelFromList(Location1) {
    QuestionModel questionModel = new QuestionModel();
    questionModel.question = Location1[iter]['question'];

    List<String> options = [
      Location1[iter]['option1'],
      Location1[iter]['option2'],
      Location1[iter]['option3'],
      Location1[iter]['option4'],
    ];
    options.shuffle();
    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = Location1[iter]['option1'];
    questionModel.answered = false;

    return questionModel;
  }
// END OF QUIZ

  @override
  void initState() {
    super.initState();
    getposts(location, widget.trailname);
    _getCurrentLocation();
    //getQuestionModelFromList(location);
    _correct = 0;
  }

  @override
  Widget build(BuildContext context) {
// For controlling the view of the Map
    // Determining the screen width & height
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              markers: markers != null ? Set<Marker>.from(markers) : null,
              initialCameraPosition: _initialLocation,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              polylines: Set<Polyline>.of(polylines.values),
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),
            Positioned(
              top: height * 0.05,
              right: width * 0.082,
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                  child: ClipOval(
                    child: Material(
                      color: Colors.orange[100], // button color
                      child: InkWell(
                        splashColor: Colors.orange, // inkwell color
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(Icons.my_location),
                        ),
                        onTap: () {
                          mapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(
                                  _currentPosition.latitude,
                                  _currentPosition.longitude,
                                ),
                                zoom: 18.0,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                child: Container(
              child: Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: new ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipOval(
                          child: Material(
                            color: Color(0xFF28495E), // button color
                            child: InkWell(
                              splashColor: Colors.blueGrey, // inkwell color
                              child: SizedBox(
                                width: 48,
                                height: 48,
                                child: Icon(
                                  CupertinoIcons.back,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                print('hi');
                                print("ITER VALUE IS: $iter");
                                if (iter > -1) {
                                  iter--;
                                  var maplen = location.length;
                                  print("MAP LENGTH IS : $maplen");
                                  setState(() {
                                    if (markers.isNotEmpty) markers.clear();
                                    if (polylines.isNotEmpty) polylines.clear();
                                    if (polylineCoordinates.isNotEmpty)
                                      polylineCoordinates.clear();
                                    _markerplace(location);
                                  });
                                  //iter--;
                                } else {
                                  print("hi");
                                }
                              },
                            ),
                          ),
                        ),
                        ClipOval(
                          child: Material(
                            color: Color(0xFF28495E), // button color
                            child: InkWell(
                              splashColor: Colors.blueGrey, // inkwell color
                              child: SizedBox(
                                width: 48,
                                height: 48,
                                child: Icon(
                                  CupertinoIcons.photo_camera,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                print('hi');
                                Dialog quiz = Dialog(
                                  // backgroundColor: Colors.pink,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      height: height * 0.8,
                                      width: width * 0.7,
                                      child: QuizPlayTile(
                                        questionModel:
                                            getQuestionModelFromList(location),
                                      )),
                                );
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) => quiz);

                                return QuizPlayTile(
                                  questionModel:
                                      getQuestionModelFromList(location),
                                );
                              },
                            ),
                          ),
                        ),
                        ClipOval(
                          child: Material(
                            color: Color(0xFF28495E), // button color
                            child: InkWell(
                              splashColor: Colors.blueGrey, // inkwell color
                              child: SizedBox(
                                width: 48,
                                height: 48,
                                child: Icon(
                                  CupertinoIcons.music_note,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                Dialog trailDetails = Dialog(
                                  // backgroundColor: Colors.pink,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    height: height * 0.8,
                                    width: width * 0.7,
                                    child: Music('$songname'),
                                  ),
                                );
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        trailDetails);
                              },
                            ),
                          ),
                        ),
                        ClipOval(
                          child: Material(
                            color: Color(0xFF28495E), // button color
                            child: InkWell(
                              splashColor: Colors.blueGrey, // inkwell color
                              child: SizedBox(
                                width: 48,
                                height: 48,
                                child: Icon(
                                  CupertinoIcons.forward,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                print("ITER VALUE IS: $iter");
                                if (iter <= location.length - 2) {
                                  var maplen = location.length;
                                  print("MAP LENGTH IS : $maplen");
                                  setState(() {
                                    if (markers.isNotEmpty) markers.clear();
                                    if (polylines.isNotEmpty) polylines.clear();
                                    if (polylineCoordinates.isNotEmpty)
                                      polylineCoordinates.clear();
                                    _markerplace(location);
                                    //_locationText();
                                  });
                                  iter++;
                                  songname = location[iter]['song'];
                                } else if (iter == location.length - 1) {
                                  print("hi");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              TrailEndScreen(
                                                  widget.trailname)));
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            )),
            Positioned(
              top: height * 0.06,
              left: width * 0.04,
              child: Container(
                child: Material(
                  color: Colors.transparent,
                  child: Center(
                    child: Ink(
                      height: height * 0.075,
                      width: width * 0.65,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue[300],
                            width: 1.5,
                          ),
                          color: Color(0xFF28495E),
                          borderRadius: BorderRadius.circular(7)),
                      child: Center(
                        child: (() {
                          if (iter < 0) {
                            return Text(
                              'Click next button to see route to 1st location',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            );
                          }
                          // else if(iter ){}
                          else if (iter <= location.length) {
                            return Text(
                              location[iter]['name'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            );
                          }
                        }()),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrailEndScreen extends StatefulWidget {
  final String trailname;
  TrailEndScreen(this.trailname, {Key key}) : super(key: key);
  @override
  _TrailEndScreenState createState() => _TrailEndScreenState();
}

class _TrailEndScreenState extends State<TrailEndScreen> {
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
                    top: sheight * 0.37,
                    left: swidth * 0.1,
                    right: swidth * 0.1,
                    child: Column(children: <Widget>[
                      ExitText(widget.trailname),
                    ]),
                  ),
                  Positioned(
                      bottom: sheight * 0.06,
                      width: swidth * 1.01,
                      child: SafeArea(
                        child: SgScape(),
                      )),
                  Positioned(
                      bottom: sheight * 0.3,
                      left: swidth * 0.32,
                      right: swidth * 0.32,
                      child: Container(
                        margin: EdgeInsets.all(sheight * 0.02),
                        //width: swidth * 0.37,
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
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TrailTabs(),
                              ),
                              ModalRoute.withName('/'),
                            );
                          },
                          child: Text(
                            'Exit',
                            style: TextStyle(
                              fontSize: 0.9 * swidth * 0.09,
                              fontFamily: 'Gidolinya',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                      ),
                  Positioned(
                    top: sheight * 0.01,
                    left: swidth * 0.01,
                    // width: swidth * 1.01,
                    child: Iconbutback(),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class ExitText extends StatefulWidget {
  final String trailname;
  ExitText(this.trailname, {Key key}) : super(key: key);
  @override
  _ExitTextState createState() => _ExitTextState();
}

class _ExitTextState extends State<ExitText> {
  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    String name = widget.trailname;
    return Container(
      // color: Colors.white,
      child: Text(
        'You have reached the end of the $name trail!', // make trail name dynamic
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF28495E),
          fontFamily: 'Gidolinya',
          fontSize: 23.5,
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
      height: sheight * 0.07,
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

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  //final int index;

  QuizPlayTile({@required this.questionModel});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";
  bool retry_colour = true;
  @override
  Widget build(BuildContext context) {
    double swidth;
    double sheight;
    swidth = MediaQuery.of(context).size.width;
    sheight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Container(
        width: swidth * 0.7,
        height: sheight * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text(widget.questionModel.question,
                  style: TextStyle(
                      fontSize: 18, color: Colors.black.withOpacity(0.8))),
            ),
            SizedBox(height: 5),
            GestureDetector(

              onTap: () {
                if (!widget.questionModel.answered) {
                  if (widget.questionModel.option1 ==
                      widget.questionModel.correctOption) {
                    setState(() {
                      optionSelected = widget.questionModel.option1;
                      widget.questionModel.answered = true;
                    });
                  } else {
                    setState(() {
                      optionSelected = widget.questionModel.option1;
                      widget.questionModel.answered = true;
                    });
                  }
                }
              },
              child: OptionTile(
                option: "A",
                answer: "${widget.questionModel.option1}",
                correctAnswer: widget.questionModel.correctOption,
                optionSelected: optionSelected,
              ),
            ),

            SizedBox(height: 4),

            GestureDetector(
              onTap: () {
                if (!widget.questionModel.answered) {
                  if (widget.questionModel.option2 ==
                      widget.questionModel.correctOption) {
                    setState(() {
                      optionSelected = widget.questionModel.option2;
                      widget.questionModel.answered = true;
                    });
                  } else {
                    setState(() {
                      optionSelected = widget.questionModel.option2;
                      widget.questionModel.answered = true;
                    });
                  }
                }
              },
              child: OptionTile(
                correctAnswer: widget.questionModel.correctOption,
                answer: "${widget.questionModel.option2}",
                option: 'B',
                optionSelected: optionSelected,
              ),
            ),

            SizedBox(height: 4),
            GestureDetector(
              onTap: () {
                if (!widget.questionModel.answered) {
                  if (widget.questionModel.option3 ==
                      widget.questionModel.correctOption) {
                    setState(() {
                      optionSelected = widget.questionModel.option3;
                      widget.questionModel.answered = true;
                    });
                  } else {
                    setState(() {
                      optionSelected = widget.questionModel.option3;
                      widget.questionModel.answered = true;
                    });
                  }
                }
              },
              child: OptionTile(
                correctAnswer: widget.questionModel.correctOption,
                answer: "${widget.questionModel.option3}",
                option: 'C',
                optionSelected: optionSelected,
              ),
            ),

            SizedBox(height: 4),
            GestureDetector(
              onTap: () {
                if (!widget.questionModel.answered) {
                  if (widget.questionModel.option4 ==
                      widget.questionModel.correctOption) {
                    setState(() {
                      optionSelected = widget.questionModel.option4;
                      widget.questionModel.answered = true;
                    });
                  } else {
                    setState(() {
                      optionSelected = widget.questionModel.option4;
                      widget.questionModel.answered = true;
                    });
                  }
                }
              },
              child: OptionTile(
                correctAnswer: widget.questionModel.correctOption,
                answer: "${widget.questionModel.option4}",
                option: 'D',
                optionSelected: optionSelected,
              ),
            ),

            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    widget.questionModel;
                    setState(() {
                      widget.questionModel.answered = false;
                      (retry_colour == true)?(retry_colour = false):(retry_colour=true);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),

                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: (retry_colour == true)
                            ? Colors.blue[300]
                            : Colors.pink[100],
                          width: 1.5,
                        ),
                        color: (retry_colour == true)
                            ? Colors.blue[200]
                            : Colors.pink[200],
                        borderRadius: BorderRadius.circular(24)),
                    child: Text(
                      'Retry',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    if (optionSelected == widget.questionModel.correctOption) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CameraScreen(),
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),

                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: (optionSelected ==
                                widget.questionModel.correctOption)
                            ? Colors.blue[300]
                            : Colors.grey,
                          width: 1.5,
                        ),
                        color: (optionSelected ==
                                widget.questionModel.correctOption)
                            ? Colors.blue[200]
                            : Colors.grey[400],
                        borderRadius: BorderRadius.circular(24)),
                    child: Text(
                      'Unlock Camera!!',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


