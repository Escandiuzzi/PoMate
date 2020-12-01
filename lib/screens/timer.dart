import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poMate/Assets/styles.dart';
import 'package:poMate/screens/analytics.dart';
import 'dart:math' as math;

bool focus = true;

final int tFocusValue = 10;
final int tRestValue = 5;

double focusPoints = 15;
double multiplier = 1.0;

Color tomatoColor = Colors.red;
Color timerColor = Color.fromARGB(255, 171, 183, 103);
Color backgroundColor = Colors.redAccent;

class PomodoroScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PomodoroTimerState();
}

class PomodoroTimerState extends State<PomodoroScreen>
    with TickerProviderStateMixin {
  AnimationController controller;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void afterTimerEnded(PomodoroScreen widget) {
    if (focus) {
      updateFocusPoints(focusPoints * multiplier);
      tomatoColor = Colors.blue;
      timerColor = Colors.yellow;
      backgroundColor = Colors.lightBlueAccent;
    } else {
      tomatoColor = Colors.red;
      timerColor = Color.fromARGB(255, 171, 183, 103);
      backgroundColor = Colors.redAccent;
      restCycle();
    }
    focus = !focus;
    controller.value = 1;
    controller.duration = Duration(seconds: focus ? tFocusValue : tRestValue);
    refresh();
  }

  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: focus ? tFocusValue : tRestValue),
        value: 1);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(8.0, 70.0, 8.0, 0),
        child: Column(
          children: <Widget>[
            Image(
              image: AssetImage('lib/Assets/Images/pomate_logo.png'),
              height: 60,
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.center,
                child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: FractionalOffset.center,
                          child: CustomPaint(
                            painter: TomatoPainter(),
                          ),
                        ),
                        Positioned.fill(
                            child: AnimatedBuilder(
                          animation: controller,
                          builder: (BuildContext context, Widget child) {
                            return new CustomPaint(
                              painter: TimerPainter(
                                  animation: controller,
                                  bgColor: backgroundColor,
                                  colour: timerColor),
                            );
                          },
                        )),
                        Align(
                          alignment: FractionalOffset.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              AnimatedBuilder(
                                  animation: controller,
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return new Text(
                                      timerString,
                                      style: themeData.textTheme.headline1,
                                    );
                                  })
                            ],
                          ),
                        ),
                        Align(
                          alignment: FractionalOffset.center,
                          child: AnimatedBuilder(
                            animation: controller,
                            builder:
                                (BuildContext dialogContext, Widget child) {
                              if (controller.value == 0) {
                                WidgetsBinding.instance.addPostFrameCallback(
                                    (_) => afterTimerEnded(this.widget));
                              }
                              return Column();
                            },
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(8.0, 0, 8.0, 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    child: AnimatedBuilder(
                        animation: controller,
                        builder: (BuildContext context, Widget child) {
                          return new Icon(
                            controller.isAnimating
                                ? Icons.pause
                                : Icons.play_arrow,
                          );
                        }),
                    onPressed: () {
                      if (!controller.isAnimating) {
                        controller.reverse(
                            from: controller.value == 0.0
                                ? 1.0
                                : controller.value);
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimerEndedPopup extends StatefulWidget {
  @override
  TimerEndedPopupState createState() => TimerEndedPopupState();
}

class TimerEndedPopupState extends State<TimerEndedPopup> {
  @override
  Widget build(BuildContext popupContext) {
    return Container(
      child: AlertDialog(
        title: Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('This is a demo alert dialog.'),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(popupContext, rootNavigator: true).pop(context);
              },
              child: Text('YAY!'))
        ],
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  TimerPainter({this.animation, this.bgColor, this.colour})
      : super(repaint: animation);

  final Animation<double> animation;
  final Color bgColor, colour;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = timerColor;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        timerColor != old.colour ||
        backgroundColor != old.bgColor;
  }
}

class TomatoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = tomatoColor
      ..style = PaintingStyle.fill;
    //a circle
    canvas.drawCircle(Offset.zero, 200, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
