import 'package:flutter/material.dart';
import 'package:hilogame/views/home_screen.dart';
import 'package:hilogame/views/profile_screen.dart';
import 'package:hilogame/views/settings_screen.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: null,
        body: DefaultTabController(
          length: 3,
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
              ),
              Scaffold(
                bottomNavigationBar: Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: TabBar(
                    tabs: <Widget>[
                      Tab(icon: Icon(Icons.home)),
                      // Tab(icon: Icon(Icons.search)),
                    //  Tab(icon: Icon(Icons.contact_support)),
                      Tab(icon: Icon(Icons.settings)),
                      Tab(icon: Icon(Icons.account_box)), 
                    ],
                    labelColor: Colors.black,
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(color: Colors.black, width: 4.0),
                        insets: EdgeInsets.only(bottom: 44)
                        ),
                        unselectedLabelColor: Colors.grey[400],
                  ),
                ),
                body: TabBarView(children: <Widget>[
                  HomeScreen(),
                  SettingScreen(),
                  ProfileScreen(),
                ],),
              )
            ],
          ),
        ));
  }
}
