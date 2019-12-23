import 'package:brewcrew/models/brew.dart';
import 'package:brewcrew/screens/home/brew_list.dart';
import 'package:brewcrew/services/auth_service.dart';
import 'package:brewcrew/services/database_service.dart';
import 'package:brewcrew/shared/setttings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return SettingsForm();
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.grey,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () {
                authService.signout();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text("Settings"),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
