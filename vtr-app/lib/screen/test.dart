import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class test extends StatefulWidget {
  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Expanded(
        child: Scaffold(
          appBar: AppBar(title: Text("test")),
        ),
      ),
    );
  }
}
