import 'package:flutter/material.dart';
import 'package:utopia_cms/src/delegate/cms_to_many_delegate.dart';
import 'package:utopia_cms/src/model/cms_filter.dart';
import 'package:utopia_cms/src/ui/widget/dropdown/to_many/cms_to_many_dropdown_state.dart';
import 'package:utopia_cms/src/util/foundation.dart';
import 'package:utopia_cms/src/util/json_map.dart';
import 'package:utopia_cms_ui/utopia_cms_ui.dart';

class CmsToManyDropdownField extends HookWidget {
  final CmsToManyDelegate delegate;
  final Object? originId;
  final String label;
  final String Function(JsonMap) valueLabelBuilder;
  final List<String>? filterFields;
  final CmsFilter Function(String)? filterBuilder;

  const CmsToManyDropdownField({
    super.key,
    required this.label,
    required this.valueLabelBuilder,
    required this.delegate,
    required this.originId,
    this.filterFields,
    this.filterBuilder,
  }) : assert(filterFields != null || filterBuilder != null);

  @override
  Widget build(BuildContext context) {
    final state = useCmsToManyDropdownState(
      delegate: delegate,
      originId: originId,
      filterFields: filterFields,
      filterBuilder: filterBuilder,
    );

    return CmsOverlayAnchor(
      maxHeight: 360,
      triggerBuilder: (context, open) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: state.isReady ? open : null,
        child: _buildTrigger(context, state),
      ),
      overlayBuilder: (context, close) => _buildPopup(context, state),
    );
  }

  Widget _buildTrigger(BuildContext context, CmsToManyDropdownState state) {
    final selectedLabels = state.selectedValues.map(valueLabelBuilder).join(', ');
    return CmsLabeledField(
      label: label,
      value: selectedLabels,
      suffix: Icon(Icons.keyboard_arrow_down, size: 18, color: context.colors.accent),
    );
  }

  Widget _buildPopup(BuildContext context, CmsToManyDropdownState state) {
    final items = state.items;
    final selectedIds = state.selectedValues.map((it) => it[delegate.foreignIdKey]).toISet();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSearch(context, state),
        if (items == null)
          const Padding(padding: EdgeInsets.all(24), child: CmsLoader())
        else if (items.isEmpty)
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text('No results', style: context.textStyles.text.copyWith(color: context.colors.hint)),
          )
        else
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return CmsCheckRow(
                  label: valueLabelBuilder(item),
                  selected: selectedIds.contains(item[delegate.foreignIdKey]),
                  onTap: () => state.onToggle(item),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildSearch(BuildContext context, CmsToManyDropdownState state) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        autofocus: true,
        style: context.textStyles.text,
        onChanged: (value) => state.searchState.value = value,
        decoration: InputDecoration(
          isDense: true,
          hintText: 'Search',
          hintStyle: context.textStyles.text.copyWith(color: context.colors.hint),
          prefixIcon: Icon(Icons.search, size: 18, color: context.colors.hint),
          filled: true,
          fillColor: context.colors.field,
          border: OutlineInputBorder(borderRadius: context.theme.borderRadius, borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
