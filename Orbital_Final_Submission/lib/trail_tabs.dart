import 'package:flutter/material.dart';
import 'preset_trails_tab.dart';
import './custom_trails_tab.dart';

class TrailTabs extends StatefulWidget {
  @override
  _TrailTabsState createState() => _TrailTabsState();
}

class _TrailTabsState extends State<TrailTabs> {
  int _trailTabIndex = 0;
  Widget callTrailTab(int _trailTabIndex){
    switch (_trailTabIndex) {
      case 0: return PresetTrails();
      case 1: return CustomTrails(); 
        
        break;
      default: return PresetTrails();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: callTrailTab( _trailTabIndex),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _trailTabIndex,
          backgroundColor: Color(0xFF621351),
          selectedItemColor: Colors.pink[100],
          unselectedItemColor: Colors.blueGrey[200],
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.storage),
              title: Text('Preset trails'),
              backgroundColor: Color(0xFF621351),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              title: Text('Custom trails'),
              backgroundColor: Color(0xFF621351),
            )
          ],
          onTap: (index) {
            setState(() {
              _trailTabIndex = index;
            });
          }),
    );
  }
}
