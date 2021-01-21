import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('SettingScreen'),
        backgroundColor: Colors.grey[600],
        elevation: 0.0,
        actions:<Widget> [

        ],
      ),
    );
  }
}
