import 'package:flutter/material.dart';
import 'package:hilogame/theme/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hilogame/views/splash_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HiLo Game',
      routes: AppRoutes.define(),
      home: SplashScreen(),
      );
  }
}
