import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LogOut extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
