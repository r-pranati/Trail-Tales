import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './sgscape.dart';
import './userauth_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';

class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  bool formType = false; // false= sign in fields, true = reset password field
  final _formKey = GlobalKey<FormState>();
  String _email, _error;

  bool validate() {
    final form = _formKey.currentState;

    form.save();

    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void submit() async {
    if (validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
        _error = 'A password reset link has been sent to $_email';
      } catch (e) {
        setState(() {
          _error = e.message;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double swidth;
    double sheight;
    swidth = MediaQuery.of(context).size.width;
    sheight = MediaQuery.of(context).size.height;
    // TODO: implement build
    return SafeArea(
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
                top: sheight * 0.2,
                left: swidth * 0.1,
                right: swidth * 0.1,
                child: Column(children: <Widget>[
                  SigninText(), // "reset password"
                ]),
              ),
              Positioned(
                  bottom: sheight * 0.38,
                  left: swidth * 0.23,
                  right: swidth * 0.23,
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
                      onPressed: submit,
                      child: Text(
                        'Send reset link',
                        style: TextStyle(
                          fontSize: 0.7 * swidth * 0.09,
                          fontFamily: 'Gidolinya',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
              Positioned(
                  bottom: sheight * 0.06,
                  width: swidth * 1.01,
                  child: SafeArea(
                    child: SgScape(),
                  )),
              Positioned(
                top: sheight * 0.01,
                left: swidth * 0.01,
                // width: swidth * 1.01,
                child: Iconbutback(),
              ),
              Positioned(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: buildInputs(),
                  ),
                ),
              ),
              Positioned(
                top: 0.1,
                height: sheight * 0.1,
                width: swidth,
                child: showAlert(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showAlert() {
    double swidth;
    double sheight;
    swidth = MediaQuery.of(context).size.width;
    sheight = MediaQuery.of(context).size.height;
    if (_error != null) {
      return Container(
        color: Color(0xFF7C0E52),
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.error_outline,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Text(
                _error,
                maxLines: 3,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _error = null;
                    });
                  }),
            ),
          ],
        ),
      );
    }
    return SizedBox(height: 0);
  }

  ////////
  List<Widget> buildInputs() {
    double swidth;
    double sheight;
    swidth = MediaQuery.of(context).size.width;
    sheight = MediaQuery.of(context).size.height;

    return [
      Padding(
        padding: EdgeInsets.only(
          top: sheight * 0.35,
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: swidth * 0.05),
        child: TextFormField(
          validator: EmailValidator.validate,
          decoration: InputDecoration(
            hintText: 'Email',
            hintStyle: TextStyle(fontSize: 18),
            errorStyle: TextStyle(fontSize: 14, color: Color(0xFF7C0E52)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: Color(0xFF7C0E52),
                width: 2.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: Color(0xFF7C0E52),
                width: 2.0,
              ),
            ),
          ),
          onSaved: (value) => _email = value,
        ),
      ),
    ];
  }
}

class SigninText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    return Container(
      // color: Colors.white,
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          'Reset Password',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF28495E),
            fontFamily: 'Gidolinya',
            fontSize: 0.9 * swidth * 0.15,
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

