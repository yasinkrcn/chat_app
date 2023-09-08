import 'package:flutter/material.dart';

class DottedBorder extends StatelessWidget {
  final double? width;
  final double? height;
  final Color borderColor;
  final double borderWidth;
  final double gapSize;
  final Widget child;

  const DottedBorder({
    super.key,
    this.width,
    this.height,
    this.borderColor = Colors.red,
    this.borderWidth = 2.5,
    this.gapSize = 8.0,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedBorderPainter(
        color: borderColor,
        strokeWidth: borderWidth,
        gapSize: gapSize,
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gapSize;

  DottedBorderPainter({this.color = Colors.black, this.strokeWidth = 2.0, this.gapSize = 4.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double halfStrokeWidth = strokeWidth / 2;

    double startX = halfStrokeWidth;
    double endX = size.width - halfStrokeWidth;
    double startY = halfStrokeWidth;
    double endY = size.height - halfStrokeWidth;

    while (startX < endX) {
      canvas.drawLine(Offset(startX, startY), Offset(startX + gapSize, startY), paint);
      startX += gapSize * 2;
    }

    while (startY < endY) {
      canvas.drawLine(Offset(startX, startY), Offset(startX, startY + gapSize), paint);
      startY += gapSize * 2;
    }

    while (startX > halfStrokeWidth) {
      canvas.drawLine(Offset(startX, startY), Offset(startX - gapSize, startY), paint);
      startX -= gapSize * 2;
    }

    while (startY > halfStrokeWidth) {
      canvas.drawLine(Offset(startX, startY), Offset(startX, startY - gapSize), paint);
      startY -= gapSize * 2;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
