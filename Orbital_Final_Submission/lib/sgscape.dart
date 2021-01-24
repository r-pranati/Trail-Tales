import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SgScape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 1, minHeight: 1), // here(
        child: Image.asset(
          'assets/images/sg_scape.png',
          // scale: .3,
        ),
      ),
    );
  }
}

class Applogo extends StatelessWidget {
  final double len;
  final double wid;
  Applogo(this.len, this.wid);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        "assets/images/logo.png",
        width: len,
        height: wid,
      ),
    );
  }
}
