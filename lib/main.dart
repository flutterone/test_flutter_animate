import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:test_flutter_animate/circle_anim.dart';


// raw prototype animate test app
// TODO: refactoring code

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'flutter test animate', home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  Color _color;
  final random = Random();
  Offset _offset = Offset.zero;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _color = Colors.white;
    super.initState();
  }

  // Function get random color
  Color getRandomColor() {
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  void _animateColor() {
    _changeColorScreen();
    if (_animationController.status == AnimationStatus.completed ||
        _animationController.status == AnimationStatus.forward) {
      _animationController.reset();
      _animationController.forward();
    } else
      _animationController.forward();
  }

// Function change random color background
  void _changeColorScreen() {
    final color = getRandomColor();
    setState(() {
      _color = color;
    });
  }

  void getOffset(TapUpDetails val) {
    setState(() {
      _offset = Offset(val.globalPosition.dx, val.globalPosition.dy);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _animateColor();
        print('tap');
      },
      onTapUp: getOffset,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            CircleAnim(
              offset: _offset,
              animation: _animation,
              color: _color,
            ),
            Center(
              child: Text(
                'Hey there',
                style: TextStyle(fontSize: 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
