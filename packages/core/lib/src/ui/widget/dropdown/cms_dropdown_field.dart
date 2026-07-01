import 'package:flutter/material.dart';
import 'package:utopia_cms/src/ui/widget/overlay/cms_overlay_anchor.dart';
import 'package:utopia_cms/src/ui/widget/wrapper/cms_labeled_field.dart';
import 'package:utopia_cms/src/util/context_extensions.dart';

class CmsDropdownField<T> extends StatelessWidget {
  final T? value;
  final void Function(T) onChanged;
  final List<T> values;
  final String label;
  final String Function(T) valueLabelBuilder;

  const CmsDropdownField({
    super.key,
    required this.value,
    required this.onChanged,
    required this.values,
    required this.label,
    required this.valueLabelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return CmsOverlayAnchor(
      triggerBuilder: (context, open) =>
          GestureDetector(behavior: HitTestBehavior.opaque, onTap: open, child: _buildTrigger(context)),
      overlayBuilder: (context, close) => ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          for (final option in values)
            _buildOption(
              context,
              option,
              selected: option == value,
              onTap: () {
                onChanged(option);
                close();
              },
            ),
        ],
      ),
    );
  }

  Widget _buildTrigger(BuildContext context) {
    final value = this.value;
    // `null` may be a real, selectable option (e.g. a filter's "All"): show its
    // label like any other value so the default reads as a selection, not an
    // empty field. The resting placeholder is reserved for fields where `null`
    // is genuinely "unset" (not present in [values]).
    final hasValue = value != null || values.contains(null);
    return CmsLabeledField(
      label: label,
      value: hasValue ? valueLabelBuilder(value as T) : null,
      suffix: Icon(Icons.keyboard_arrow_down, size: 18, color: context.textStyles.text.color),
    );
  }

  Widget _buildOption(BuildContext context, T option, {required bool selected, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: context.colors.hover,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(valueLabelBuilder(option), style: context.textStyles.text, overflow: TextOverflow.ellipsis),
            ),
            if (selected) Icon(Icons.check, size: 16, color: context.colors.accent),
          ],
        ),
      ),
    );
  }
}
