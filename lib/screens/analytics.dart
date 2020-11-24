import 'package:flutter/material.dart';
import 'package:poMate/Controller/user.dart';
import 'package:poMate/main.dart';
import 'package:poMate/screens/login.dart';

const TextStyle optionStyle = TextStyle(
    fontSize: 35, fontWeight: FontWeight.bold, fontFamily: 'SofiaPro');

double fPoints = 0;
double graphHeight = 0;

User _user = new User(userCredentialR.user.uid, userCredentialR.user.displayName, fPoints.toString(), userCredentialR.user.email);

void updateFocusPoints(double points) {
  fPoints += points;

  if (fPoints > 300)
    graphHeight = 300;
  else
    graphHeight = fPoints;

  _user.focusPoints = fPoints.toString();
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
          child: Text(
            fPoints.toString(),
            style: optionStyle,
          ),
        ),
        CustomPaint(
          painter: GraphicPainter(),
        ),
        SizedBox(
          height: 60,
        ),
      ],
    );
  }
}

class GraphicPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.redAccent
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(-100, 350, 50, -graphHeight), paint);
    paint.color = Colors.redAccent;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
