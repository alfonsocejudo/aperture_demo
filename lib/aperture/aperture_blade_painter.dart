/*
 * Created by Alfonso Cejudo, Saturday, July 13th 2019.
 */

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ApertureBladePainter extends CustomPainter {
  final double rotationRadians;
  final double borderWidth;
  final Paint borderPaint;
  final Paint fillPaint;

  ApertureBladePainter(
      {@required this.borderWidth,
      this.rotationRadians,
      Paint borderPaint,
      Paint fillPaint})
      : this.borderPaint = borderPaint != null ? borderPaint : Paint()
          ..color = Colors.black,
        this.fillPaint = fillPaint != null ? fillPaint : Paint()
          ..style = PaintingStyle.fill
          ..color = Colors.grey.shade900;

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = math.sqrt((math.pow(width, 2) - math.pow((width / 2), 2)));

    canvas.save();
    canvas.rotate(rotationRadians);

    Path borderPath = Path()
      ..moveTo(0, width)
      ..lineTo(width / 2, width - height)
      ..lineTo(width, width)
      ..close();

    canvas.drawPath(borderPath, borderPaint);

    Path fillPath = Path()
      ..moveTo((borderWidth * 2), width - borderWidth)
      ..lineTo(width / borderWidth, width - height + (borderWidth * 2))
      ..lineTo(width - (borderWidth * 2), width - borderWidth)
      ..close();

    canvas.drawPath(fillPath, fillPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
