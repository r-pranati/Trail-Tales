import 'package:Trailtales/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './my_flutter_app_icons.dart';
import './sgscape.dart';
import './user_auth.dart';
import './userauth_validator.dart';
import './userauth_provider.dart';
import './dashboard.dart';
import './resetpass.dart';

class SignIn extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<SignIn> {
  bool formType = false; // false= sign in fields, true = reset password field
  final _formKey = GlobalKey<FormState>();
  String _email, _password, _error;

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

  ///////////// ORIGINAL SUBMIT()///////////////
  void submit() async {
    if (validate()) {
      try {
        final auth = Provider.of(context).auth;
        String userId = await auth.signInWithEmailAndPassword(
          _email,
          _password,
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardScreen(),
          ),
          ModalRoute.withName('/'),
        );
      
      } catch (e) {
        setState(() {
          _error = e.message;
        });
      }
    }
  }

  void resetPasswordSubmit() async {
    if (validate()) {
      try {
        Auth auth = Provider.of(context).auth;

        await auth.sendPasswordResetEmail(_email);
        _error = 'A password reset link has been sent to $_email';
        Navigator.of(context, rootNavigator: true).pop(context);
      } catch (e) {
        setState(() {
          _error = e.message;
          Navigator.of(context, rootNavigator: true).pop(context);
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
                  top: sheight * 0.1,
                  left: swidth * 0.1,
                  right: swidth * 0.1,
                  child: Column(children: <Widget>[
                    SigninText(),
                  ]),
                ),
                Positioned(
                  top: sheight * 0.1,
                  left: swidth * 0.1,
                  right: swidth * 0.1,
                  child: Column(children: <Widget>[
                    SigninText(),
                  ]),
                ),
                // Positioned(
                //   top: sheight * 0.58,
                //   left: swidth * 0.1,
                //   right: swidth * 0.1,
                //   child: Column(children: <Wid2get>[
                //     SigninAltrText(),
                //   ]),
                // ),
                Positioned(
                    bottom: sheight * 0.38,
                    left: swidth * 0.27,
                    right: swidth * 0.27,
                    child: Container(
                      margin: EdgeInsets.all(sheight * 0.02),
                      
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
                          'sign-in',
                          style: TextStyle(
                            fontSize: 0.9 * swidth * 0.09,
                            fontFamily: 'Gidolinya',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )),
                Positioned(
                    bottom: sheight * 0.32,
                    left: swidth * 0.21,
                    right: swidth * 0.19,
                    child: Container(
                      margin: EdgeInsets.all(sheight * 0.02),
                      
                      height: sheight * 0.05,
                      child: FlatButton(
                        

                        onPressed: () {
                          //resetPass();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>ForgotScreen()));
                        }, //onPressed
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 0.6 * swidth * 0.09,
                            fontFamily: 'Gidolinya',
                            color: Color(0xFF28495E),
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
      ),
    );
  }

  // Widget resetPass() {
  //   return Scaffold(
  //     body: null,
  //   );
  // }

  ////////
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
          top: sheight * 0.20,
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
      Padding(
        padding: EdgeInsets.only(
            top: sheight * 0.02, left: swidth * 0.2, right: swidth * 0.3),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: swidth * 0.05),
        child: TextFormField(
          cursorColor: Colors.white,
          validator: PasswordValidator.validate,
          decoration: InputDecoration(
            hintText: 'Password',
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
          obscureText: true,
          onSaved: (value) => _password = value,
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
 
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          'Sign-in',
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

class SigninAltrText extends StatelessWidget {
  //'or sign in with'
  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    return Container(
      
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          '- or sign in with -',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF28495E),
            fontFamily: 'Gidolinya',
            fontSize: swidth * 0.08,
          ),
        ),
      ),
    );
  }
}

class Iconbut1 extends StatelessWidget {
  Iconbut1();
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
              icon: Icon(MyFlutterApp.google),
              color: Colors.white,
              onPressed: () {
                print("hi");
              },
            ),
          ),
        ),
      ),
    );
  }
}

class Iconbut2 extends StatelessWidget {
  Iconbut2();
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
              icon: Icon(MyFlutterApp.facebook),
              color: Colors.white,
              onPressed: () {
                print("hi");
              },
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
