import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tugas_flutter_3/main_menu.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool _anim1 = false;
  bool _anim2 = false;
  bool _anim3 = false;
  bool _anim4 = false;
  bool _anim5 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 900), (() {
      setState(() {
        _anim1 = !_anim1;
      });
    }));
    Timer(Duration(milliseconds: 900), (() {
      setState(() {
        _anim2 = !_anim2;
      });
    }));
    Timer(Duration(seconds: 2), (() {
      setState(() {
        _anim3 = !_anim3;
      });
    }));
    Timer(Duration(seconds: 3), (() {
      setState(() {
        _anim4 = !_anim4;
      });
    }));
    Timer(Duration(seconds: 4), (() {
      setState(() {
        _anim5 = !_anim5;
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.ease,
                  width: MediaQuery.of(context).size.width,
                  height: _anim1 ? MediaQuery.of(context).size.height / 2 : 0,
                  color: Color(0xff362222),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.ease,
                  width: MediaQuery.of(context).size.width,
                  height: _anim1 ? MediaQuery.of(context).size.height / 2 : 0,
                  color: Color(0xff362222),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.ease,
                  height: MediaQuery.of(context).size.height,
                  width: _anim2 ? MediaQuery.of(context).size.width / 2 : 0,
                  color: Color.fromARGB(255, 23, 23, 23),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.ease,
                  height: MediaQuery.of(context).size.height,
                  width: _anim2 ? MediaQuery.of(context).size.width / 2 : 0,
                  color: Color.fromARGB(255, 23, 23, 23),
                ),
              ),
            ],
          ),
          Column(
            children: [
              BoxAnim3(Alignment.centerLeft),
              BoxAnim3(Alignment.centerRight),
              BoxAnim3(Alignment.centerLeft),
              BoxAnim3(Alignment.centerRight),
              BoxAnim3(Alignment.centerLeft),
              BoxAnim3(Alignment.centerRight),
              BoxAnim3(Alignment.centerLeft),
              BoxAnim3(Alignment.centerRight),
              BoxAnim3(Alignment.centerLeft),
              BoxAnim3(Alignment.centerRight),
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.ease,
              width: _anim4 ? MediaQuery.of(context).size.width : 0,
              height: _anim4 ? 500 : 0,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(280)),
                  color: Color(0xff3B3B3B)),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            curve: Curves.easeInOutCubic,
            top: 150,
            left: _anim5 ? 20 : MediaQuery.of(context).size.width * -1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "WELCOME TO",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  "JMDB",
                  style: TextStyle(
                    color: Color(0xffEDDBC5),
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    // decoration: TextDecoration.underline
                  ),
                ),
                Container(
                  width: 205,
                  child: Text(
                    "see some movie information you are looking for",
                    style: TextStyle(
                      color: Color(0xffEDDBC5),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            curve: Curves.bounceOut,
            bottom: _anim5
                ? 36
                : _anim5
                    ? 20
                    : MediaQuery.of(context).size.width * -1 / 2,
            left: 30,
            right: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MainMenu()));
                  },
                  child: Text("Let's Go",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(primary: Color(0xff3B3B3B)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget BoxAnim3(Alignment rata) {
    return Align(
      alignment: rata,
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        curve: Curves.ease,
        height: MediaQuery.of(context).size.height / 10,
        width: _anim3 ? MediaQuery.of(context).size.width : 0,
        color: _anim4 ? Color(0xff171010) : Color(0xff423F3E),
      ),
    );
  }
}
