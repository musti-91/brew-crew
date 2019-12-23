import 'package:brewcrew/constants.dart';
import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/services/database_service.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugures = ['0', '1', '2', '3', '4'];
  String _currentName;
  String _currentSugur;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snap) {
          if (snap.hasData) {
            return Form(
              autovalidate: true,
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Update crew options',
                      style: TextStyle(color: Colors.pink, fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      initialValue: snap.data.name ?? "create new Name",
                      decoration: useDecorator.copyWith(hintText: 'Name'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DropdownButtonFormField(
                      autovalidate: true,
                      isDense: true,
                      value: _currentSugur,
                      decoration: useDecorator,
                      onChanged: (val) => setState(() => _currentSugur = val),
                      items: sugures.map((f) {
                        return DropdownMenuItem(
                          child: Text('$f sugur(s)'),
                          value: f,
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    //slider
                    Slider(
                      value:
                          (_currentStrength ?? snap.data.strength).toDouble(),
                      min: 100.0,
                      max: 900.0,
                      label: '$_currentStrength',
                      onChanged: (val) =>
                          setState(() => _currentStrength = val.round()),
                      divisions: 8,
                      activeColor: Colors.brown[_currentStrength ?? 100],
                      inactiveColor: Colors.brown[_currentStrength ?? 100],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      child: Text('Update'),
                      textColor: Colors.white,
                      color: Colors.pink,
                      onPressed: () async {
                        print(_currentName);
                        print(_currentSugur);
                        print(_currentStrength);
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
