import 'package:flutter/material.dart';
import 'package:hilogame/theme/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OpeningView extends StatefulWidget {
  @override
  _OpeningViewState createState() => _OpeningViewState();
}

class _OpeningViewState extends State<OpeningView> {
  _OpeningViewState();

  String displayName = "";

  @override //get user data
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      displayName = prefs.getString('displayName');
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    /* final logo = Image.asset(
      "asset/logo.jpg",
      height: mq.size.height / 4,
    ); */

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.grey[600],
      child: MaterialButton(
        minWidth: mq.size.width / 1.2,
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
        child: Text(
          'Login',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          print('Login Pressed');

          //setState(() => loading = true);
          Navigator.of(context).pushNamed(AppRoutes.authLogin);
        },
      ),
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.grey[600],
      child: MaterialButton(
        minWidth: mq.size.width / 1.2,
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
        child: Text(
          'Register',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          print('Register Pressed');
          Navigator.of(context).pushNamed(AppRoutes.authregister);
        },
      ),
    );

    final buttons = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        loginButton,
        Padding(
          padding: EdgeInsets.fromLTRB(0, 15, 0, 70),
          child: registerButton,
        ),
      ],
    );

    display() {
      if (displayName != null)
        return Text(
          "Welcome back $displayName",
          style: TextStyle(color: Colors.white, fontSize: 25),
        );
      else
        return Text("Welcome back!",
            style: TextStyle(color: Colors.white, fontSize: 25));
    }

    return Scaffold(
        //backgroundColor: Color(0xff8c52ff),
        //Gredient__________________________
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white,Colors.green, Colors.black26])),
      //____________________________________
      padding: EdgeInsets.all(36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 50),
            //child: logo,
          ),
          Padding(
            padding: EdgeInsets.only(top: 50, bottom: 50),
            child: display(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50, bottom: 50),
            child: buttons,
          )
        ],
      ),
    ));
  }
}
