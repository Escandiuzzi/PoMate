import 'package:flutter/material.dart';

const TextStyle optionStyle = TextStyle(
    fontSize: 35, fontWeight: FontWeight.bold, fontFamily: 'SofiaPro');

const TextStyle cardStyle = TextStyle(
    fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Arciform');

const TextStyle cardSubStyle = TextStyle(fontSize: 13, fontFamily: 'Arciform');

class RankingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        SizedBox(
          height: 40,
        ),
        Center(
          child: Text(
            'Ranking',
            style: optionStyle,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Card(
          child: ListTile(
            title: Text(
              'Luiz Felipe Escandiuzzi',
              style: cardStyle,
            ),
            subtitle: Text(
              '7772316 points of focus',
              style: cardSubStyle,
            ),
            trailing: Icon(Icons.filter_1),
          ),
          margin: EdgeInsets.all(10),
        ),
        Card(
          child: ListTile(
            title: Text('Leonardo Martelli Oliveira', style: cardStyle),
            subtitle: Text('12236 points of focus', style: cardSubStyle),
            trailing: Icon(Icons.filter_2),
          ),
          margin: EdgeInsets.all(10),
        ),
        Card(
          child: ListTile(
            title: Text('Carlos Eduardo', style: cardStyle),
            subtitle: Text('7777 points of focus', style: cardSubStyle),
            trailing: Icon(Icons.filter_3),
          ),
          margin: EdgeInsets.all(10),
        ),
        Card(
          child: ListTile(
            title: Text('Gregor Yannis Way', style: cardStyle),
            subtitle: Text('123 points of focus', style: cardSubStyle),
          ),
          margin: EdgeInsets.all(10),
        ),
      ],
    );
  }
}
