import 'package:flutter/material.dart';
import 'package:utopia_cms/src/util/context_extensions.dart';

/// A non-Material selectable row: a label preceded by a check box, used inside
/// dropdown popups. Styled from the CMS theme, no ink splash.
class CmsCheckRow extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const CmsCheckRow({super.key, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: colors.hover,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            _CheckBox(selected: selected),
            const SizedBox(width: 12),
            Expanded(
              child: Text(label, style: context.textStyles.text, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckBox extends StatelessWidget {
  final bool selected;

  const _CheckBox({required this.selected});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: selected ? colors.accent : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: selected ? colors.accent : colors.disabled, width: 1.5),
      ),
      child: selected ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
    );
  }
}
