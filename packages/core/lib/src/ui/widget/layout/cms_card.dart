import 'package:flutter/material.dart';
import 'package:utopia_cms/src/util/context_extensions.dart';

/// A raised, rounded, hairline-bordered surface - the container the table and
/// other grouped content sit on. Styling comes from `CmsThemeData.cardDecoration`
/// and `cardBorderDecoration`, so it stays themable from one place.
class CmsCard extends StatelessWidget {
  final Widget child;

  const CmsCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: context.theme.cardDecoration,
      foregroundDecoration: context.theme.cardBorderDecoration,
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}

/// The sliver counterpart of [CmsCard]: wraps [sliver] in the card decoration -
/// a filled, rounded, shadowed back layer plus a foreground hairline border.
///
/// A [DecoratedSliver] does not clip its child, so round the last row yourself
/// (see `CmsTableItem`) to keep it off the rounded bottom corners.
Widget cmsCardSliver(BuildContext context, {required Widget sliver}) {
  final theme = context.theme;
  return DecoratedSliver(
    decoration: theme.cardDecoration,
    sliver: DecoratedSliver(
      decoration: theme.cardBorderDecoration,
      position: DecorationPosition.foreground,
      sliver: sliver,
    ),
  );
}
