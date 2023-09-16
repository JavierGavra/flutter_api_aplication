import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_flutter_3/ui/pages/home/home_page.dart';
import 'package:tugas_flutter_3/ui/pages/intro/intro_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future _navigatePage(BuildContext context) async {
    var prefs = await SharedPreferences.getInstance();
    bool alreadyIntro = await prefs.getBool('alreadyIntro') ?? false;
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => alreadyIntro ? HomePage() : IntroPage()),
        (route) => false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _navigatePage(context);
    return Scaffold(
      backgroundColor: Color(0xff171010),
      body: Center(
        child: Text(
          "JMDB",
          style: TextStyle(color: Color(0xffEDDBC5), fontSize: 42, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
