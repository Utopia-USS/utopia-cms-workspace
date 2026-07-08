import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utopia_cms/src/model/menu/cms_widget_menu_params.dart';
import 'package:utopia_cms/src/ui/cms_widget/cms_shell_menu_scope.dart';
import 'package:utopia_cms/src/ui/cms_widget/cms_widget_item.dart';
import 'package:utopia_cms/src/util/foundation.dart';
import 'package:utopia_cms_ui/utopia_cms_ui.dart';

class CmsWidget extends HookWidget {
  final List<CmsWidgetItem> items;
  final CmsThemeData? theme;
  final MutableValue<String>? selectedPageId;
  final CmsWidgetMenuParams menuParams;

  const CmsWidget({
    super.key,
    required this.items,
    this.theme,
    this.selectedPageId,
    this.menuParams = const CmsWidgetMenuParams(),
  });

  @override
  Widget build(BuildContext context) {
    final selectedPageIdState =
        selectedPageId ?? useState(useMemoized(() => items.whereType<CmsWidgetItemPage>().first.id));
    final scaffoldKey = useMemoized(GlobalKey<ScaffoldState>.new);

    // `CmsSidebar.onDestinationPressed` only fires for selectable pages -
    // `CmsSidebarAction` items invoke their own `onPressed` directly (see
    // `_CmsWidgetItemSidebarX.toSidebarItem`), which also closes the drawer
    // when tapped there. This keeps the drawer-close-on-tap behavior for both
    // item kinds while letting the sidebar itself stay free of scaffold
    // coupling.
    void onDestinationPressed(CmsSidebarDestination destination, {required bool fromDrawer}) {
      selectedPageIdState.value = destination.id;
      if (fromDrawer) scaffoldKey.currentState?.closeDrawer();
    }

    return CmsTheme(
      data: theme ?? CmsThemeData.defaultTheme,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Shell breakpoint is measured on the full window width, before the
          // sidebar takes its share - tablet and phone both fall to the drawer.
          final isDrawer = constraints.maxWidth < CmsBreakpoints.sidebarMin;
          final content = _buildContent(selectedPageIdState.value);
          final style = menuParams.toSidebarStyle();

          return Scaffold(
            key: scaffoldKey,
            backgroundColor: context.colors.canvas,
            drawerScrimColor: Colors.black.withValues(alpha: 0.32),
            drawer: isDrawer
                ? CmsSidebar(
                    presentation: CmsSidebarPresentation.drawer,
                    items: [
                      for (final item in items)
                        item.toSidebarItem(closeDrawer: () => scaffoldKey.currentState?.closeDrawer()),
                    ],
                    selectedId: selectedPageIdState.value,
                    style: style,
                    onDestinationPressed: (destination) => onDestinationPressed(destination, fromDrawer: true),
                  )
                : null,
            body: Provider.value(
              value: CmsShellMenuScope(isDrawer: isDrawer, openDrawer: () => scaffoldKey.currentState?.openDrawer()),
              child: isDrawer
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: CmsSidebar.shellGutter),
                      child: content,
                    )
                  : Row(
                      children: [
                        CmsSidebar(
                          items: [
                            for (final item in items) item.toSidebarItem(closeDrawer: null),
                          ],
                          selectedId: selectedPageIdState.value,
                          style: style,
                          onDestinationPressed: (destination) => onDestinationPressed(destination, fromDrawer: false),
                        ),
                        Expanded(
                          // Left padding is the single shell gutter between sidebar
                          // and content (the menu carries no right margin); right
                          // padding matches it so the shell gutters stay uniform.
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: CmsSidebar.shellGutter),
                            child: content,
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(String selectedPageId) {
    return CrossFadeIndexedStack(
      duration: const Duration(milliseconds: 400),
      index: items.indexWhere((it) => it is CmsWidgetItemPage && it.id == selectedPageId),
      lazy: true,
      children: [
        for (final item in items)
          item.map(
            page: (it) => it.content,
            action: (_) => const SizedBox.shrink(),
            custom: (_) => const SizedBox.shrink(),
          ),
      ],
    );
  }
}

/// Adapts the domain [CmsWidgetItem] union to the ui package's presentation-
/// only [CmsSidebarItem] union rendered by [CmsSidebar].
extension _CmsWidgetItemSidebarX on CmsWidgetItem {
  /// [closeDrawer] (non-null only on the drawer path) preserves the
  /// drawer-close-on-tap behavior that used to live inside core's own
  /// `CmsMenu`: `CmsSidebar` never closes anything itself (no scaffold
  /// coupling), and `CmsSidebarAction.onPressed` is invoked by the sidebar
  /// directly rather than routed back through `onDestinationPressed`, so the
  /// drawer-close call has to be baked into the action here instead.
  /// `CmsSidebarDestination` taps are still routed through
  /// `CmsWidget.onDestinationPressed`, which closes the drawer itself.
  CmsSidebarItem toSidebarItem({required VoidCallback? closeDrawer}) => map(
    page: (it) => CmsSidebarDestination(id: it.id, label: it.title, icon: it.icon),
    action: (it) => CmsSidebarAction(
      label: it.title,
      icon: it.icon,
      onPressed: () {
        it.onPressed();
        closeDrawer?.call();
      },
    ),
    // The sidebar column fills the viewport and scrolls on overflow, so
    // `flex` maps onto a plain `Expanded`: a flex spacer item pushes the
    // items after it to the sidebar's bottom edge, exactly as the old rail
    // did.
    custom: (it) => CmsSidebarCustom(
      builder: (_) => it.flex == null ? it.child : Expanded(flex: it.flex!, child: it.child),
    ),
  );
}

/// Adapts core's domain-side [CmsWidgetMenuParams] to the ui package's
/// presentation-only [CmsSidebarStyle], field for field.
extension _CmsWidgetMenuParamsSidebarX on CmsWidgetMenuParams {
  CmsSidebarStyle toSidebarStyle() => CmsSidebarStyle(backgroundColors: backgroundColors, headerBuilder: headerBuilder);
}
