import 'package:flutter/material.dart';
import 'dart:math' as math;

const TextStyle optionStyle = TextStyle(
    fontSize: 35, fontWeight: FontWeight.bold, fontFamily: 'SofiaPro');

const TextStyle cardStyle = TextStyle(
    fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Arciform');

const TextStyle cardSubStyle = TextStyle(fontSize: 13, fontFamily: 'Arciform');

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
      theme: ThemeData(brightness: Brightness.dark),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    AnalyticsScreen(),
    PomodoroScreen(),
    RankingScreen(),
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
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.equalizer),
              label: 'My analytics',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Timer'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Ranking'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }
}

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

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: FractionalOffset.topCenter,
              child: Text('PoMate Timer', style: optionStyle),
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
                                  backgroundColor: Colors.redAccent,
                                  color: Color.fromARGB(255, 171, 183, 103)),
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
                      ],
                    )),
              ),
            ),
            Container(
                margin: EdgeInsets.all(8.0),
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
                        if (controller.isAnimating)
                          controller.stop();
                        else {
                          controller.reverse(
                              from: controller.value == 0.0
                                  ? 1.0
                                  : controller.value);
                        }
                      },
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  TimerPainter({this.animation, this.backgroundColor, this.color})
      : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}

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

class TomatoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    //a circle
    canvas.drawCircle(Offset.zero, 175, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
