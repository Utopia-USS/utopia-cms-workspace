import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:utopia_cms/src/util/foundation.dart';

/// Three dots pulsing in a staggered wave - the loading indicator shown inside
/// CmsButton. Hand-rolled so core does not depend on `flutter_spinkit`.
class CmsThreeBounce extends HookWidget {
  final Color? color;
  final double size;

  const CmsThreeBounce({super.key, this.color, this.size = 20});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: const Duration(milliseconds: 1400));
    useEffect(() {
      unawaited(controller.repeat());
      return null;
    }, [controller]);

    final dotSize = size * 0.5;
    return SizedBox(
      height: size,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) => Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            final scale = (math.sin((controller.value - index * 0.2) * 2 * math.pi) + 1) / 2;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: dotSize * 0.15),
              child: Transform.scale(
                scale: scale,
                child: SizedBox.square(
                  dimension: dotSize,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
