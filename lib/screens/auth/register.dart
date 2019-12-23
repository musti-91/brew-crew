import 'package:brewcrew/constants.dart';
import 'package:brewcrew/services/auth_service.dart';
import 'package:brewcrew/shared/Loading.dart';

import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: Text('Register new user'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    widget.toggleView();
                  },
                  label: Text('Sign In'),
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: useDecorator.copyWith(hintText: "Email"),
                      validator: (val) =>
                          val.isEmpty ? 'Email is required' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      // TODO move validation
                      decoration: useDecorator.copyWith(hintText: "Password"),
                      validator: (val) => val.length < 6
                          ? 'Password should be more than 6 charachters'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic res = await _auth.signup(email, password);
                          if (res == null) {
                            // error
                            setState(() {
                              error = "Please supply a valid email";
                              loading = false;
                            });
                          } else {}
                        }
                      },
                      child: Text('Register'),
                    ),
                    SizedBox(
                      height: 20.0,
                      child: Text(
                        error,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
