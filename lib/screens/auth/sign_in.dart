import 'package:brewcrew/constants.dart';
import 'package:brewcrew/services/auth_service.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _signFormKey = GlobalKey<FormState>();

  bool loading = false;
  // textfields state
  String email = '';
  String password = '';
  String error = "";
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Sign In brew Crew '),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Sign up'),
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _signFormKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: useDecorator.copyWith(hintText: "Email"),
                      validator: (val) =>
                          val.isEmpty ? 'Email is requiured' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: useDecorator.copyWith(hintText: "Password"),
                      validator: (val) => val.length < 6
                          ? 'Passwors should more than 6 charchters'
                          : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      child: Text('Sign In'),
                      onPressed: () async {
                        if (_signFormKey.currentState.validate()) {
                          setState(() => loading = true);
                          // do something
                          // todo will change later
                          dynamic res = _auth.signin(email, password);
                          if (res == null) {
                            setState(() {
                              error = 'Email, or password not correct';
                              loading = false;
                            });
                          } else {
                            setState(() => loading = !loading);
                          }
                        }
                      },
                      color: Colors.pink,
                      textColor: Colors.white,
                    ),
                    SizedBox(
                      height: 20.0,
                      child: Text(error, style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
