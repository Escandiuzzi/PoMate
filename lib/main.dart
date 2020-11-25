import 'package:flutter/material.dart';
import 'package:poMate/screens/login.dart';
import 'package:poMate/screens/analytics.dart';
import 'package:poMate/screens/ranking.dart';
import 'package:poMate/screens/timer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference itemRef = database.reference();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //itemRef = database.reference().child('items');
  //itemRef.onChildAdded.listen(_onEntryAdded);
  //itemRef.onChildChanged.listen(_onEntryChanged);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomBarWidget(),
      theme: ThemeData(brightness: Brightness.dark),
    );
  }
}

class BottomBarWidget extends StatefulWidget {
  BottomBarWidget({Key key}) : super(key: key);

  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  int _selectedIndex = 1;
  static List<Widget> _widgetOptions = <Widget>[
    AnalyticsScreen(),
    PomodoroScreen(),
    RankingScreen(),
    LoginPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.cyanAccent,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.equalizer), label: 'My analytics'),
            BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Timer'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Ranking'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: 'Login'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }
}
