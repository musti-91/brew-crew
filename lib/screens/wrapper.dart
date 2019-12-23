import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/screens/auth/authticate.dart';
import 'package:brewcrew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) return Authenticate();

    return Home();
  }
}
