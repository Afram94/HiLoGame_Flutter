import 'package:flutter/material.dart';
import 'package:hilogame/theme/routes.dart';
import 'package:hilogame/views/logout.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LogOut _auth = LogOut();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final playNowButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.grey[600],
      child: MaterialButton(
          minWidth: mq.size.width / 1.2,
          padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
          child: Text(
            "PlayNow",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async {
            Navigator.of(context).pushNamed(AppRoutes.authPlay);
          }),
    );

    /* final navigationbar = Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.grey[600],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            label: Text(
              "Logout",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
              Navigator.of(context).pushNamed(AppRoutes.logout);
            },
          ),
        ],
      ),
    ); */

    return Scaffold(appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.grey[600],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            label: Text(
              "Logout",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
              Navigator.of(context).pushNamed(AppRoutes.logout);
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Form(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(36),
          child: Container(
            height: mq.size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                //navigationbar,
                Padding(
                  padding: EdgeInsets.only(bottom: 150),
                  child: playNowButton,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
