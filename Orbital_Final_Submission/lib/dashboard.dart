import 'package:Trailtales/homepage.dart';
import 'package:Trailtales/preset_trails_tab.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import './foldrawer.dart';
import './trail_tabs.dart';
import './preset_trails_tab.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  FSBStatus status;
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
                  // Navigator.of(context).pop(true)
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

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _onbackpressed,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              FoldableSidebarBuilder(
                  drawerBackgroundColor: Color(0xFF75B5E7),
                  status: status,
                  drawer: CustomDrawer(),
                  screenContents: MapDashboard()),
              Positioned(
                top: sheight * 0.02,
                right: swidth * 0.02,
                child: FloatingActionButton(
                  backgroundColor: Color(0xFF621351),
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      status = status == FSBStatus.FSB_OPEN
                          ? FSBStatus.FSB_CLOSE
                          : FSBStatus.FSB_OPEN;
                      print('hi');
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MapDashboard extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapDashboard> {
  Completer<GoogleMapController> controller1;

  static LatLng _initialPosition;
  static LatLng _lastMapPosition = _initialPosition;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  void _getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      print('${placemark[0].name}');
    });
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      controller1.complete(controller);
    });
  }

  MapType _currentMapType = MapType.normal;

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  Widget mapButton(Function function, Icon icon, Color color) {
    return RawMaterialButton(
      onPressed: function,
      child: icon,
      shape: new CircleBorder(),
      elevation: 2.0,
      fillColor: color,
      padding: const EdgeInsets.all(7.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _initialPosition == null
          ? Container(
              child: Center(
                child: Text(
                  'loading map..',
                  style: TextStyle(
                      fontFamily: 'Avenir-Medium', color: Colors.grey[400]),
                ),
              ),
            )
          : Container(
              child: Stack(children: <Widget>[
                GoogleMap(
                  mapType: _currentMapType,
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 15,
                    tilt: 17,
                  ),
                  onMapCreated: _onMapCreated,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  onCameraMove: _onCameraMove,
                  myLocationEnabled: true,
                  compassEnabled: false,
                  myLocationButtonEnabled: false,
                ),
                Positioned(
                  bottom: sheight * 0.02,
                  left: swidth * 0.1,
                  right: swidth * 0.1,
                  child: Iconbut(),
                ),
              ]),
            ),
    );
  }
}

class Iconbut extends StatelessWidget {
  Iconbut();
  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    return Container(
      height: sheight * 0.09,
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Ink(
            decoration: const ShapeDecoration(
              color: Color(0xFFF50057),
              shape: CircleBorder(),
            ),
            child: Center(
              child: IconButton(
                icon: Icon(
                  IconData(58131, fontFamily: 'MaterialIcons'),
                ),
                iconSize: 35,
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      //builder: (context) => PresetTrails(),
                      builder: (context) => TrailTabs(),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
