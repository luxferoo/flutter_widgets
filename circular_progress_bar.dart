import 'dart:math';
import 'package:flutter/material.dart';

class CircularProgressBar extends StatelessWidget {
  @required
  final Color progressColor;
  @required
  final double progressWith;
  @required
  final double width;
  @required
  final Color color;
  @required
  final double progression;
  @required
  final Color thumbColor;
  @required
  final double thumbWidth;
  @required
  final EdgeInsets padding;
  final Widget child;

  CircularProgressBar({
    this.progressColor = Colors.redAccent,
    this.progressWith = 5.0,
    this.width = 5.0,
    this.color = Colors.white,
    this.progression = 0.0,
    this.thumbColor = Colors.redAccent,
    this.thumbWidth = 5.0,
    this.child,
    this.padding = const EdgeInsets.all(0.0),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Padding(
        child: child,
        padding: padding,
      ),
      painter: _CustomPainter(
        progressColor: progressColor,
        progressWith: progressWith,
        width: width,
        color: color,
        progression: progression,
        thumbWidth: thumbWidth,
        thumbColor: thumbColor,
      ),
    );
  }
}

class _CustomPainter extends CustomPainter {
  final Color progressColor;
  final double progressWith;
  final double width;
  final Color color;
  final double progression;
  final Color thumbColor;
  final double thumbWidth;
  final Paint complete;
  final Paint line;
  final Paint thumb;

  _CustomPainter({
    this.progressColor,
    this.progressWith,
    this.width,
    this.color,
    this.progression,
    this.thumbColor,
    this.thumbWidth,
  })  : line = new Paint()
          ..color = progressColor
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke
          ..strokeWidth = progressWith,
        complete = new Paint()
          ..color = color
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke
          ..strokeWidth = width,
        thumb = new Paint()
          ..color = thumbColor
          ..style = PaintingStyle.fill
          ..strokeWidth = thumbWidth;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    double arcAngle = 2 * pi * progression;

    canvas.drawCircle(center, radius, complete);
    canvas.drawArc(
      new Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      arcAngle,
      false,
      line,
    );

    final thumbAngle = 2 * pi * progression - (pi / 2);
    final thumbX = cos(thumbAngle) * radius;
    final thumbY = sin(thumbAngle) * radius;
    final thumbCenter = Offset(thumbX, thumbY) + center;
    canvas.drawCircle(thumbCenter, thumbWidth, thumb);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
