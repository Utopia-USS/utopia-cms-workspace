import 'package:flutter/material.dart';
import 'package:utopia_cms_ui/utopia_cms_ui.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

import '../widgets/section.dart';

/// Switches and check rows - the boolean controls.
class SelectionSection extends HookWidget {
  /// Creates the selection section.
  const SelectionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final switchState = useState(true);
    final switchFieldState = useState(true);
    final checkedState = useState(true);

    return SheetSection(
      title: 'Selection',
      subtitle: 'Switches and check rows - the boolean controls.',
      child: Wrap(
        spacing: 32,
        runSpacing: 24,
        children: [
          SpecimenTile(
            label: 'CmsSwitch',
            child: CmsSwitch(value: switchState.value, onChanged: (value) => switchState.value = value),
          ),
          const SpecimenTile(label: 'CmsSwitch - read only', child: CmsSwitch(value: true, readOnly: true)),
          const SpecimenTile(label: 'CmsSwitch - disabled', child: CmsSwitch(value: false)),
          SpecimenTile(
            label: 'CmsSwitchField',
            width: 320,
            child: CmsSwitchField(
              value: switchFieldState.value,
              title: 'Email notifications',
              onChanged: (value) => switchFieldState.value = value,
            ),
          ),
          SpecimenTile(
            label: 'CmsCheckRow',
            width: 240,
            child: CmsCheckRow(
              label: 'Include archived',
              selected: checkedState.value,
              onTap: () => checkedState.value = !checkedState.value,
            ),
          ),
        ],
      ),
    );
  }
}
