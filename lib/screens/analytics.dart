import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poMate/Assets/styles.dart';
import 'package:poMate/Controller/appuser.dart';
import 'package:poMate/main.dart';
import 'package:poMate/screens/login.dart';
import 'package:poMate/screens/timer.dart';

double fPoints = 0;
double graphHeight = 0;

int fCycles = 0;
int rCycles = 0;

AppUser _user = new AppUser(
    userCredentialR.user.uid,
    userCredentialR.user.displayName,
    fPoints.toString(),
    userCredentialR.user.email,
    rCycles.toString(),
    fCycles.toString());

void updateFocusPoints(double points) {
  fPoints += points;
  fCycles += 1;

  if (fPoints > 300)
    graphHeight = 300;
  else
    graphHeight = fPoints;

  updateFirebaseDB();
}

void restCycle() {
  rCycles += 1;
  updateFirebaseDB();
}

void updateFirebaseDB() {
  _user.focusPoints = fPoints.toString();
  _user.restCycles = rCycles.toString();
  _user.focusCycles = fCycles.toString();

  itemRef.child(_user.uid).update(_user.toJson());
}

class AnalyticsScreen extends StatefulWidget {
  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 80, 0, 50),
          child: Center(
              child: Text(
            'My Analytics',
            style: optionStyle,
          )),
        ),
        CircleAvatar(
          backgroundImage: NetworkImage(
            userCredentialR.user.photoURL,
          ),
          radius: 60,
          backgroundColor: Colors.transparent,
        ),
        SizedBox(height: 40),
        Text(
          'NAME',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'SofiaPro',
              color: Colors.lightBlueAccent),
        ),
        SizedBox(height: 5),
        Text(
          userCredentialR.user.displayName,
          style: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        /*Padding(
          padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
          child: Center(
            child: Text(
              'Time spent producing: ${fCycles * tFocusValue} seconds',
              style: infoStyle,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Center(
            child: Text(
              'Time spent resting: ${rCycles * tRestValue} seconds',
              style: infoStyle,
            ),
          ),
        ),*/
        Padding(
          padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
          child: Center(
            child: Text(
              'Focus points:    ${fPoints.toString()}',
              style: infoStyle,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Center(
            child: Text(
              'Focus cycles:    ${fCycles.toString()}',
              style: infoStyle,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Center(
            child: Text(
              'Rest cycles:    ${rCycles.toString()}',
              style: infoStyle,
            ),
          ),
        ),
      ],
    );
  }
}
