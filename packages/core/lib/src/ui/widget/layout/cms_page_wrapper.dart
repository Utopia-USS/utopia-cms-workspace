import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utopia_cms/src/ui/widget/layout/cms_breakpoints.dart';

/// Responsive size class derived from the available width, not the screen size.
///
/// Because [CmsPageWrapper] resolves the type from local [BoxConstraints], it
/// composes inside sub-regions (the management overlay, a dialog, a column)
/// and not only at the top of the screen.
enum CmsPageType { mobile, tablet, web }

extension CmsPageTypeX on CmsPageType {
  /// Column count for a chunked/grid layout: one more column per size class,
  /// starting from [base] on mobile.
  int chunkedSize(int base) => switch (this) {
    CmsPageType.mobile => base,
    CmsPageType.tablet => base + 1,
    CmsPageType.web => base + 2,
  };

  bool get isMobile => this == CmsPageType.mobile;

  bool get isTablet => this == CmsPageType.tablet;

  bool get isWeb => this == CmsPageType.web;
}

/// Resolves a [CmsPageType] from the available width and exposes it to the
/// subtree both through the [builder] callback and through `context.pageType`.
///
/// A responsive page wrapper: a plain [LayoutBuilder] resolves the size class
/// and `package:provider` exposes it to the subtree, so the wrapper carries no
/// extra dependency.
class CmsPageWrapper extends StatelessWidget {
  final Widget Function(BuildContext context, CmsPageType pageType) builder;

  /// When true, caps the content width and centers it at the top - matching the
  /// shell's constrained reading width.
  final bool isConstrained;

  const CmsPageWrapper({super.key, required this.builder, this.isConstrained = false});

  static const double maxConstrainedWidth = 1340;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final pageType = resolveType(constraints.maxWidth);
        final child = Provider<CmsPageType>.value(
          value: pageType,
          child: Builder(builder: (context) => builder(context, pageType)),
        );
        if (!isConstrained) return child;
        return Container(
          constraints: const BoxConstraints(maxWidth: maxConstrainedWidth),
          alignment: Alignment.topCenter,
          child: child,
        );
      },
    );
  }

  static CmsPageType resolveType(double width) {
    if (width < CmsBreakpoints.tabletMin) return CmsPageType.mobile;
    if (width < CmsBreakpoints.webMin) return CmsPageType.tablet;
    return CmsPageType.web;
  }
}

extension CmsPageTypeContextX on BuildContext {
  /// The [CmsPageType] provided by the nearest [CmsPageWrapper] ancestor.
  CmsPageType get pageType => Provider.of<CmsPageType>(this);
}
