import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:utopia_cms/src/ui/widget/wrapper/cms_field_wrapper.dart';
import 'package:utopia_cms/src/util/context_extensions.dart';
import 'package:utopia_cms/src/util/foundation.dart';

/// A prominent, full-width search field: a leading magnifier, a muted [hint]
/// and no floating label - the search affordance at the top of a `CmsTable`
/// card. Shares its field decoration and text state with `CmsTextField`.
class CmsSearchField extends HookWidget {
  final String value;
  final String hint;
  final void Function(String?) onChanged;
  final List<TextInputFormatter>? formatters;

  const CmsSearchField({super.key, required this.value, required this.hint, required this.onChanged, this.formatters});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final state = useFieldState(initialValue: value);
    useEffect(() => onChanged(state.value.isEmpty ? null : state.value), [state.value]);

    return TextEditingControllerWrapper(
      text: state,
      builder: (controller) => CmsFieldWrapper(
        child: Row(
          children: [
            Icon(Icons.search, size: 18, color: colors.hint),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: controller,
                cursorColor: colors.primary,
                inputFormatters: formatters,
                textInputAction: TextInputAction.search,
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                style: context.textStyles.text,
                decoration: InputDecoration(
                  isCollapsed: true,
                  border: InputBorder.none,
                  hintText: hint,
                  hintStyle: context.textStyles.text.copyWith(color: colors.hint),
                ),
              ),
            ),
            if (state.value.isNotEmpty) _ClearButton(onTap: () => state.value = ''),
          ],
        ),
      ),
    );
  }
}

class _ClearButton extends StatelessWidget {
  final void Function() onTap;

  const _ClearButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Icon(Icons.close, size: 16, color: context.colors.hint),
        ),
      ),
    );
  }
}
