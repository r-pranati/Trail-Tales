import 'package:flutter/material.dart';
import './user_auth.dart';

class Provider extends InheritedWidget {
  final BaseAuth auth;

  Provider({
    Key key,
    Widget child,
    this.auth,
  }) : super(
          key: key,
          child: child,
        );

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

    static Provider of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<Provider>();
}
