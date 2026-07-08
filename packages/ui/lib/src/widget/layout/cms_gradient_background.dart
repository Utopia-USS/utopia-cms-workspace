import 'package:flutter/material.dart';
import 'package:utopia_cms_ui/src/util/cms_context_extensions.dart';

/// An animated bottom-left-to-top-right gradient fill - the backing surface
/// of `CmsButton`, dimming to `CmsThemeColors.disabled` when [isEnabled] is
/// `false`.
class CmsGradientBackground extends StatelessWidget {
  /// The content laid over the gradient.
  final Widget child;

  /// Corner radius of the gradient surface.
  final BorderRadius? borderRadius;

  /// Clip behavior applied to the surface; defaults to [Clip.none].
  final Clip? clipBehavior;

  /// When `false`, renders the disabled-state fill instead of [colors].
  final bool isEnabled;

  /// Overrides the default primary/accent gradient colors.
  final List<Color>? colors;

  /// Creates the animated gradient surface.
  const CmsGradientBackground({
    super.key,
    required this.child,
    this.borderRadius,
    this.clipBehavior,
    this.isEnabled = true,
    this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final gradient = colors ?? [context.colors.primary, context.colors.accent];
    return AnimatedContainer(
      height: double.infinity,
      width: double.infinity,
      clipBehavior: clipBehavior ?? Clip.none,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: isEnabled ? gradient : [context.colors.disabled, context.colors.disabled.withValues(alpha: 0.95)],
        ),
      ),
      duration: const Duration(milliseconds: 400),
      child: child,
    );
  }
}
