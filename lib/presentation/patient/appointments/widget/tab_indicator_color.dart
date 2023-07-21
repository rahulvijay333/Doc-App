import 'package:flutter/material.dart';

class IndicatorContainer extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _IndicatorContainerBoxPainter();
  }
}

class _IndicatorContainerBoxPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = Offset(offset.dx, offset.dy + 35.0) &
        Size(configuration.size!.width/20,20.0); // Adjust height and padding as needed
    final Paint paint = Paint()
      ..color = Colors.blue; // Replace with your desired color

    canvas.drawRect(rect, paint);
  }
}