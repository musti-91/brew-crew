import 'package:brewcrew/screens/auth/register.dart';
import 'package:brewcrew/screens/auth/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool signedIn = false;

  void toggleView() {
    setState(() => signedIn = !signedIn);
  }

  @override
  Widget build(BuildContext context) {
    if (!signedIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
