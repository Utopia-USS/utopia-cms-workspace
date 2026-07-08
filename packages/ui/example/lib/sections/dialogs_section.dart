import 'package:flutter/material.dart';
import 'package:utopia_cms_ui/utopia_cms_ui.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

import '../widgets/section.dart';

/// Sheet section demoing the two dialog prefabs: [CmsDialog.form] (a
/// scrollable field sliver with a pinned action bar) and [CmsConfirmDialog]
/// (the confirm/cancel prefab). Both are launched through their own `show`
/// helpers, so this section only needs two buttons.
class DialogsSection extends StatelessWidget {
  /// Creates the dialogs sheet section.
  const DialogsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SheetSection(
      title: 'Dialogs',
      subtitle:
          'CmsDialog.form composes a scrollable field sliver with a pinned action bar; '
          'CmsConfirmDialog is the confirm/cancel prefab. Full-screen on mobile, card on desktop.',
      child: Wrap(
        spacing: 32,
        runSpacing: 24,
        children: [
          CmsButton(
            dense: true,
            maxWidth: 220,
            onTap: () => CmsDialog.show<void>(context, builder: (_) => const _SettingsDialog()),
            child: const Text('Open form dialog'),
          ),
          CmsButton(
            dense: true,
            maxWidth: 220,
            onTap: () => CmsConfirmDialog.show(
              context,
              title: 'Delete workspace?',
              subtitle: 'This is a sheet demo - nothing is deleted.',
              confirmLabel: 'Delete',
            ),
            child: const Text('Open confirm dialog'),
          ),
        ],
      ),
    );
  }
}

/// The `CmsDialog.form` demo: a workspace name field, a role dropdown, a date
/// picker and a switch in the scrollable sliver, one `CmsButton` in the
/// pinned bottom bar that just pops - a mock form has nothing to submit to.
/// (Lightweight-tier HookWidget: the dropdown/date/switch values are this
/// dialog's only state.)
class _SettingsDialog extends HookWidget {
  const _SettingsDialog();

  @override
  Widget build(BuildContext context) {
    final roleState = useState('Viewer');
    final publishedState = useState<DateTime?>(null);
    final publicSignUpState = useState(true);

    return CmsDialog.form(
      title: const Text('Workspace settings'),
      sliver: SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
        sliver: SliverList.list(
          children: [
            CmsTextField(value: 'Acme Inc.', label: const Text('Workspace name'), onChanged: (_) {}),
            const SizedBox(height: 14),
            CmsDropdownField<String>(
              label: 'Default role',
              value: roleState.value,
              values: const ['Admin', 'Editor', 'Viewer'],
              valueLabelBuilder: (value) => value,
              onChanged: (value) => roleState.value = value,
            ),
            const SizedBox(height: 14),
            CmsDatePicker(
              date: publishedState.value,
              label: 'Published',
              onDateChanged: (date) => publishedState.value = date,
            ),
            const SizedBox(height: 14),
            CmsSwitchField(
              value: publicSignUpState.value,
              title: 'Public sign-up',
              onChanged: (value) => publicSignUpState.value = value,
            ),
          ],
        ),
      ),
      bottom: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: CmsButton(onTap: () => Navigator.of(context).maybePop(), child: const Text('Done')),
      ),
    );
  }
}
