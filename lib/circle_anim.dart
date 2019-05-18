import 'package:flutter/material.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:meta/meta.dart';

class CircleAnim extends StatelessWidget {
  final Offset offset;
  final Animation<double> animation;
  final Color color;

  const CircleAnim(
      {Key key,
      @required this.offset,
      @required this.animation,
      @required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final double diagonal = sqrt(height * height + width * width);

    return CircularRevealAnimation(
      minRadius: 0,
      maxRadius: diagonal,
      center: offset,
      animation: animation,
      child: Container(
        color: color,
      ),
    );
  }
}
