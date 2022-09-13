import 'package:flutter/material.dart';
import 'package:tugas_flutter_3/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: Color(0xff2B2B2B)),
          scaffoldBackgroundColor: Color(0xff171010),
          fontFamily: 'Lato'),
      home: SplashScreen(),
    );
  }
}
