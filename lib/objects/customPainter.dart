import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    var paint = Paint();

    paint.color = Color.fromARGB(255, 141, 56, 184);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 25;

    var startPoint = Offset(paint.strokeWidth, size.height);
    var controlPoint1 = Offset(0, -size.height*0.4);
    var controlPoint2 = Offset(size.width, -size.height*0.4);
    var endPoint = Offset(size.width-paint.strokeWidth, size.height);

    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy,
        controlPoint2.dx, controlPoint2.dy,
        endPoint.dx, endPoint.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
