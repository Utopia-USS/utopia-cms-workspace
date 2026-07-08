import 'package:flutter/material.dart';
import 'package:utopia_cms_ui/src/widget/layout/cms_breakpoints.dart';

/// Responsive size class derived from the available width, not the screen size.
///
/// Because [CmsPageWrapper] resolves the type from local [BoxConstraints], it
/// composes inside sub-regions (the management overlay, a dialog, a column)
/// and not only at the top of the screen.
enum CmsPageType {
  /// Narrowest size class - below [CmsBreakpoints.tabletMin].
  mobile,

  /// Mid-width size class - between [CmsBreakpoints.tabletMin] and
  /// [CmsBreakpoints.webMin].
  tablet,

  /// Widest size class - at or above [CmsBreakpoints.webMin].
  web,
}

extension CmsPageTypeX on CmsPageType {
  /// Column count for a chunked/grid layout: one more column per size class,
  /// starting from [base] on mobile.
  int chunkedSize(int base) => switch (this) {
    CmsPageType.mobile => base,
    CmsPageType.tablet => base + 1,
    CmsPageType.web => base + 2,
  };

  /// Whether this is [CmsPageType.mobile].
  bool get isMobile => this == CmsPageType.mobile;

  /// Whether this is [CmsPageType.tablet].
  bool get isTablet => this == CmsPageType.tablet;

  /// Whether this is [CmsPageType.web].
  bool get isWeb => this == CmsPageType.web;
}

/// Resolves a [CmsPageType] from the available width and exposes it to the
/// subtree both through the [builder] callback and through `context.pageType`.
///
/// A responsive page wrapper: a plain [LayoutBuilder] resolves the size class
/// and a private [InheritedWidget] exposes it to the subtree, so the wrapper
/// carries no extra dependency.
class CmsPageWrapper extends StatelessWidget {
  /// Builds the subtree, receiving the [CmsPageType] resolved from the
  /// available width.
  final Widget Function(BuildContext context, CmsPageType pageType) builder;

  /// When true, caps the content width and centers it at the top - matching the
  /// shell's constrained reading width.
  final bool isConstrained;

  /// Creates a responsive page wrapper.
  const CmsPageWrapper({super.key, required this.builder, this.isConstrained = false});

  /// The width applied to the content area when [isConstrained] is `true`.
  static const double maxConstrainedWidth = 1340;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final pageType = resolveType(constraints.maxWidth);
        final child = _CmsPageScope(
          pageType: pageType,
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

  /// Maps a raw width to a [CmsPageType] using [CmsBreakpoints.tabletMin] and
  /// [CmsBreakpoints.webMin].
  static CmsPageType resolveType(double width) {
    if (width < CmsBreakpoints.tabletMin) return CmsPageType.mobile;
    if (width < CmsBreakpoints.webMin) return CmsPageType.tablet;
    return CmsPageType.web;
  }
}

/// Distributes the [CmsPageType] resolved by the nearest [CmsPageWrapper] to
/// its subtree, mirroring the `CmsTheme` `InheritedWidget` pattern.
class _CmsPageScope extends InheritedWidget {
  final CmsPageType pageType;

  const _CmsPageScope({required this.pageType, required super.child});

  @override
  bool updateShouldNotify(_CmsPageScope oldWidget) => pageType != oldWidget.pageType;
}

extension CmsPageTypeContextX on BuildContext {
  /// The [CmsPageType] provided by the nearest [CmsPageWrapper] ancestor.
  ///
  /// Throws a [FlutterError] if no [CmsPageWrapper] ancestor exists - matching
  /// the previous `package:provider`-based behavior, which threw a
  /// `ProviderNotFoundException` in the same situation.
  CmsPageType get pageType {
    final scope = dependOnInheritedWidgetOfExactType<_CmsPageScope>();
    if (scope == null) {
      throw FlutterError(
        'context.pageType was called with a context that does not contain a CmsPageWrapper.\n'
        'No CmsPageWrapper ancestor could be found starting from the context that was passed to '
        'context.pageType. This can happen if the context you used comes from a widget above the '
        'CmsPageWrapper.',
      );
    }
    return scope.pageType;
  }
}
