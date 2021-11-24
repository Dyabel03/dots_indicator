import 'package:flutter/material.dart';

import '../effects/expanding_dots_effect.dart';
import 'indicator_painter.dart';

class ExpandingDotsPainter extends BasicIndicatorPainter {
  final ExpandingDotsEffect effect;

  ExpandingDotsPainter({
    required double offset,
    required this.effect,
    required int count,
  }) : super(offset, count, effect);

  @override
  void paint(Canvas canvas, Size size) {
    final current = offset.floor();
    var drawingOffset = -effect.spacing;
    final dotOffset = offset - current;
    // print('dotOffset::: $dotOffset');
    for (var i = 0; i < count; i++) {
      print('INI i::: $i ______________________________________');

      var scale = 1.0;
      final smallDotScale = 0.5;
      final revDotOffset = 1 - dotOffset;
      // TODO: se quema la cant maxima
      final switchPoint = (/*effect.maxVisibleDots*/ 7 - 1) / 2;
      var isCurrent = false;

      if (i >= current - switchPoint && i <= current + (switchPoint + 1)) {
        if (i == (current + switchPoint)) {
          scale = smallDotScale + ((1 - smallDotScale) * dotOffset);
        } else if (i == current - (switchPoint - 1)) {
          scale = 1 - (1 - smallDotScale) * dotOffset;
        } else if (i == current - switchPoint) {
          scale = (smallDotScale * revDotOffset);
        } else if (i == current + (switchPoint + 1)) {
          scale = (smallDotScale * dotOffset);
        }
      } else {
        continue;
      }
      final center = size.center(Offset.zero).dx;

      var color = effect.dotColor;
      final activeDotWidth = effect.dotWidth * effect.expansionFactor;
      final expansion =
          (dotOffset / 2 * ((activeDotWidth - effect.dotWidth) / .5));
      final xPos = drawingOffset + effect.spacing;
      var width = effect.dotWidth * scale;
      if (i == current) {
        // ! Both a and b are non nullable
        color = Color.lerp(effect.activeDotColor, effect.dotColor, dotOffset)!;
        width = activeDotWidth - expansion;
        isCurrent = true;
      } else if (i - 1 == current || (i == 0 && offset > count - 1)) {
        width = effect.dotWidth + expansion;
        // ! Both a and b are non nullable
        color = Color.lerp(
            effect.activeDotColor, effect.dotColor, 1.0 - dotOffset)!;
      }

      // ****** TEST 1

      // sirve
      // final startingPoint =
      //     center - width / 2 - (offset * (effect.dotWidth + effect.spacing));
      // final xPosTemp = startingPoint + (effect.dotWidth + effect.spacing) * i;

      final startingPoint =
          center - width / 2 - (offset * (effect.dotWidth + effect.spacing));
      final xPosTemp = startingPoint + (effect.dotWidth + effect.spacing) * i;

      // print('startingPoint $startingPoint');
      // print('xPosTemp::: $xPosTemp');

      final yPos = size.height / 2;
      final rRect = RRect.fromLTRBR(
        xPosTemp,
        yPos - effect.dotHeight * scale / 2,
        xPosTemp + width,
        yPos + effect.dotHeight * scale / 2,
        dotRadius,
      );

      // ****** ORIGINAL

      // final yPos = size.height / 2;
      // final rRect = RRect.fromLTRBR(
      //   xPos,
      //   yPos - effect.dotHeight / 2,
      //   xPos + width,
      //   yPos + effect.dotHeight / 2,
      //   dotRadius,
      // );
      // ******

      drawingOffset = rRect.right;

      canvas.drawRRect(rRect, dotPaint..color = color);
    }
  }
}
