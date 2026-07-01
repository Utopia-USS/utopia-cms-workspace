import 'package:flutter/material.dart';
import 'package:utopia_cms/src/ui/cms_widget/cms_widget_item.dart';
import 'package:utopia_cms/src/util/context_extensions.dart';
import 'package:utopia_cms/src/util/foundation.dart';

class CmsMenuTile extends StatelessWidget {
  final CmsWidgetItem item;
  final bool isExpanded, isSelected;

  /// Whether the tile sits on a coloured (gradient) menu rather than the default
  /// light surface card - drives the content / selection colours.
  final bool onColored;
  final void Function() onPressed;

  const CmsMenuTile({
    super.key,
    required this.item,
    required this.isExpanded,
    required this.isSelected,
    required this.onColored,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final contentColor = onColored
        ? (context.textStyles.button.color ?? Colors.white)
        : (isSelected ? colors.primary : colors.text);
    final selectedColor = onColored ? Colors.white.withValues(alpha: 0.18) : colors.chipBackground;
    final hoverColor = onColored ? Colors.white.withValues(alpha: 0.08) : colors.hover;
    final baseStyle = onColored ? context.textStyles.button : context.textStyles.label;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      child: Material(
        color: isSelected ? selectedColor : Colors.transparent,
        borderRadius: context.theme.borderRadius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          hoverColor: hoverColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: IconTheme.merge(
              data: IconThemeData(color: contentColor, size: 22),
              child: DefaultTextStyle(
                style: baseStyle.copyWith(color: contentColor),
                child: Row(
                  children: [
                    item.icon,
                    Flexible(child: _buildText(context)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    final duration = isExpanded ? const Duration(milliseconds: 400) : const Duration(milliseconds: 150);
    return AnimatedOpacity(
      curve: Curves.easeOutExpo,
      duration: duration,
      opacity: isExpanded ? 1 : 0,
      child: Collapsible.horizontal(
        isExpanded: isExpanded,
        curve: Curves.easeOutExpo,
        duration: duration,
        child: AnimatedScale(
          scale: isExpanded ? 1 : 0,
          curve: Curves.easeOutExpo,
          duration: duration,
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: DefaultTextStyle.merge(overflow: TextOverflow.ellipsis, child: item.title),
          ),
        ),
      ),
    );
  }
}
