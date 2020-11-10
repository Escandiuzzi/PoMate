import 'package:flutter/material.dart';

const TextStyle optionStyle = TextStyle(
    fontSize: 35, fontWeight: FontWeight.bold, fontFamily: 'SofiaPro');

class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 70,
        ),
        Center(
            child: Text(
          'My Analytics',
          style: optionStyle,
        )),
        SizedBox(
          height: 100,
        ),
        Center(
          child: Image(
            image: AssetImage('lib/Assets/Images/analytics.png'),
          ),
        ),
        SizedBox(
          height: 60,
        ),
      ],
    );
  }
}
