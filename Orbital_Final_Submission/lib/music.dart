import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
// import 'dart:math' show pi;

typedef void OnError(Exception exception);

// void main() {
//   runApp(new MaterialApp(debugShowCheckedModeBanner: true, home: MyApp()));
// }

class Music extends StatefulWidget {
  final String songpath;
  Music(this.songpath, {Key key}) : super(key: key);
  @override
  MusicState createState() => MusicState();
}

class MusicState extends State<Music> {
  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    return MaterialApp(
        title: 'Title',
        home: SafeArea(
          child: Scaffold(
            body: Center(
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: swidth * 0.6,
                    height: sheight * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(40.0),
                        topRight: const Radius.circular(40.0),
                        bottomLeft: const Radius.circular(40.0),
                        bottomRight: const Radius.circular(40.0),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF75B5E7),
                          Color(0xFF75B5E9),
                          Color(0xFF7AD5E3),
                          Color(0xFFEBC9C6),
                          Color(0xFFF3E7E7),
                          Color(0xFFF3E7E9),
                        ],
                        stops: [0, 0.1, 0.2, 0.44, 0.77, 1],
                      ),
                    ),
                    child: LocalAudio(widget.songpath),
                  ),
                ],
              ),
            ),
          ),
        )
        //LocalAudio(),
        );
  }
}

class LocalAudio extends StatefulWidget {
  final String songpath1;
  LocalAudio(this.songpath1, {Key key}) : super(key: key);
  @override
  _LocalAudio createState() => _LocalAudio();
}

class _LocalAudio extends State<LocalAudio> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;
  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.durationHandler = (d) => setState(() {
          _duration = d;
        });

    advancedPlayer.positionHandler = (p) => setState(() {
          _position = p;
        });
  }

  Widget _tab(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: children
                .map((w) => Container(child: w, padding: EdgeInsets.all(6.0)))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _btnplay(VoidCallback onPressed) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 2.0,
      fillColor: Colors.white,
      child: Icon(
        Icons.play_arrow,
        size: 20.0,
      ),
      padding: EdgeInsets.all(15.0),
      shape: CircleBorder(),
    );
  }

  Widget _btnpause(VoidCallback onPressed) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 2.0,
      fillColor: Colors.white,
      child: Icon(
        Icons.pause,
        size: 20.0,
      ),
      padding: EdgeInsets.all(15.0),
      shape: CircleBorder(),
    );
  }

  Widget _btnstop(VoidCallback onPressed) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 2.0,
      fillColor: Colors.white,
      child: Icon(
        Icons.stop,
        size: 20.0,
      ),
      padding: EdgeInsets.all(15.0),
      shape: CircleBorder(),
    );
  }

  Widget slider() {
    return Slider(
        activeColor: Colors.black,
        inactiveColor: Colors.pink,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            seekToSecond(value.toInt());
            value = value;
          });
        });
  }

  Widget LocalAudio() {
    return _tab([
      _btnplay(() => audioCache.play(widget.songpath1)),
      _btnpause(() => advancedPlayer.pause()),
      _btnstop(() => advancedPlayer.stop()),
      slider()
    ]);
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    advancedPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   elevation: 1.0,
        //   backgroundColor: Colors.teal,
        //   title: Center(child: Text('LOCAL AUDIO')),
        // ),
        body: TabBarView(
          children: [LocalAudio()],
        ),
      ),
    );
  }
}