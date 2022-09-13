import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: "Search Film",
            hintStyle: TextStyle(
                color: Color.fromARGB(255, 146, 146, 146), fontSize: 17),
          ),
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white, fontSize: 17),
          onChanged: (value) {},
        ),
      ),
      body: Container(),
    );
  }
}
