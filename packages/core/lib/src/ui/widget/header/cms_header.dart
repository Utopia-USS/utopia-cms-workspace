import 'package:flutter/material.dart';
import 'package:utopia_cms/src/ui/cms_widget/cms_shell_menu_scope.dart';
import 'package:utopia_cms/src/util/context_extensions.dart';

class CmsHeader extends StatelessWidget {
  final String text;
  final bool navigateBack;

  const CmsHeader({super.key, required this.text, this.navigateBack = false});

  @override
  Widget build(BuildContext context) {
    // Surface the drawer-open affordance only on a top-level page title (not the
    // overlay's back header) and only when the sidebar is actually a drawer.
    final scope = CmsShellMenuScope.maybeOf(context);
    final showMenuButton = !navigateBack && (scope?.isDrawer ?? false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (navigateBack) _buildNavigateBack(context),
        Row(
          children: [
            if (showMenuButton) ...[_MenuButton(onPressed: scope!.openDrawer), const SizedBox(width: 8)],
            Flexible(child: Text(text, style: context.textStyles.header)),
          ],
        ),
      ],
    );
  }

  Widget _buildNavigateBack(BuildContext context) {
    final style = context.textStyles.title;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              Icon(Icons.arrow_back, color: style.color),
              const SizedBox(width: 4),
              Text("Back", style: style),
            ],
          ),
        ),
      ),
    );
  }
}

/// The drawer-open ("burger") button shown beside the page title when the
/// sidebar is hidden behind a drawer.
class _MenuButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _MenuButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        hoverColor: context.colors.hover,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(Icons.menu, color: context.colors.text, size: 26),
        ),
      ),
    );
  }
}
