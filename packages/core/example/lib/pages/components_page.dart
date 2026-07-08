import 'package:flutter/material.dart';
import 'package:utopia_cms_ui/utopia_cms_ui.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

/// "Components" - a standalone tour of the utopia_cms_ui design system.
///
/// Every demo below is wired with typed mock data and `package:utopia_cms_ui`
/// APIs only - no CMS delegate, no `JsonMap`, no entry model. This is the
/// litmus test from the ui package's CHARTER.md made concrete: "a project
/// that needs an admin-panel-quality table / button / dialog but has its own
/// models, its own data layer ... must be able to adopt this component
/// without forking it."
///
/// Three sections: dialogs (a mock edit form + a confirm prompt), a sliver
/// table inside an adaptive dialog (client-side search/sort via
/// `useCmsTableState`, typed `_TeamMember` rows), and a strip of primitives.
class ComponentsPage extends StatelessWidget {
  const ComponentsPage({super.key});

  static const double _maxContentWidth = 900;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: context.theme.pageTopPadding),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text('Components', style: context.textStyles.header),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: _maxContentWidth),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(24, 24, 24, 48),
                  child: _ComponentsSections(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ComponentsSections extends StatelessWidget {
  const _ComponentsSections();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 8),
        _SectionHeading(
          title: 'Dialogs',
          subtitle:
              'CmsDialog.form composes a scrollable field sliver with a pinned action bar; '
              'CmsConfirmDialog is the neutral confirm/cancel prefab.',
        ),
        SizedBox(height: 16),
        _DialogsSection(),
        SizedBox(height: 40),
        _SectionHeading(
          title: 'Table in a dialog',
          subtitle:
              'A CmsTable<T> of 15 typed rows inside a raw CmsDialog - client-side search and '
              'sort via useCmsTableState, no server round-trip.',
        ),
        SizedBox(height: 16),
        _TableDialogSection(),
        SizedBox(height: 40),
        _SectionHeading(title: 'Primitives', subtitle: 'The small building blocks every field and table cell is made of.'),
        SizedBox(height: 16),
        _PrimitivesSection(),
      ],
    );
  }
}

class _SectionHeading extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionHeading({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CmsTitle(title: title),
        const SizedBox(height: 6),
        Text(subtitle, style: context.textStyles.text.copyWith(color: context.colors.hint)),
      ],
    );
  }
}

/// Section 1: a mock "edit profile" [CmsDialog.form] and a [CmsConfirmDialog]
/// - both opened through their `show` helpers, both self-contained routes.
class _DialogsSection extends StatelessWidget {
  const _DialogsSection();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        CmsButton(
          dense: true,
          maxWidth: 200,
          onTap: () => CmsDialog.show<void>(context, builder: (_) => const _EditProfileDialog()),
          child: const Text('Edit profile'),
        ),
        CmsButton(
          dense: true,
          maxWidth: 200,
          onTap: () => CmsConfirmDialog.show(
            context,
            title: 'Remove member?',
            subtitle: 'This is a mock action from the showcase - nothing is actually deleted.',
            confirmLabel: 'Remove',
          ),
          child: const Text('Delete item'),
        ),
      ],
    );
  }
}

/// The `CmsDialog.form` demo: 2 text fields, a date picker and a switch in
/// the scrollable sliver, one `CmsButton` in the pinned bottom bar that just
/// pops - a mock form has nothing to submit to. (Lightweight-tier HookWidget:
/// the picked date is this dialog's only state.)
class _EditProfileDialog extends HookWidget {
  const _EditProfileDialog();

  @override
  Widget build(BuildContext context) {
    final joinedState = useState<DateTime?>(DateTime(2023, 4, 12));
    return CmsDialog.form(
      title: const Text('Edit profile'),
      sliver: SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
        sliver: SliverList.list(
          children: [
            CmsTextField(value: 'Ava Chen', label: const Text('Name'), onChanged: (_) {}),
            const SizedBox(height: 14),
            CmsTextField(value: 'Engineer', label: const Text('Role'), onChanged: (_) {}),
            const SizedBox(height: 14),
            CmsDatePicker(date: joinedState.value, label: 'Joined', onDateChanged: (it) => joinedState.value = it),
            const SizedBox(height: 14),
            CmsSwitchField(value: true, title: 'Active', onChanged: (_) {}),
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

/// Section 2 - the required demo: a [CmsButton] opening a raw [CmsDialog]
/// whose body is a [CustomScrollView] holding one [CmsTable].
class _TableDialogSection extends StatelessWidget {
  const _TableDialogSection();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: CmsButton(
        dense: true,
        maxWidth: 220,
        onTap: () => CmsDialog.show<void>(context, builder: (_) => const _TeamDirectoryDialog()),
        child: const Text('Open team directory'),
      ),
    );
  }
}

/// 15 typed [_TeamMember] rows, sortable by name/role/status and searchable
/// by name/role - all client-side via [useCmsTableState]. No delegate, no
/// pagination, no backend: the table only ever sees the in-memory list below.
class _TeamDirectoryDialog extends HookWidget {
  const _TeamDirectoryDialog();

  @override
  Widget build(BuildContext context) {
    final tableState = useCmsTableState<_TeamMember>(rows: _teamMembers, entries: _teamMemberEntries);

    return CmsDialog(
      title: const Text('Team directory'),
      builder: (context, pageType) => CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            sliver: CmsTable<_TeamMember>(
              rows: tableState.visibleRows,
              entries: _teamMemberEntries,
              rowKey: (row) => row.name,
              currentSort: tableState.currentSort,
              onSortPressed: tableState.onSortPressed,
              searchPanel: CmsTableSearchPanel(
                searchField: CmsSearchField(
                  value: tableState.searchState.value,
                  hint: 'Search by name or role',
                  onChanged: (value) => tableState.searchState.value = value ?? '',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Section 3: a strip of the small primitives every field/cell above is
/// built from, each with its own tiny bit of live state.
class _PrimitivesSection extends HookWidget {
  const _PrimitivesSection();

  @override
  Widget build(BuildContext context) {
    final switchOn = useState(true);
    final checked = useState(true);

    return Wrap(
      spacing: 32,
      runSpacing: 24,
      children: [
        _PrimitiveTile(
          label: 'CmsChipList',
          child: CmsChipList(labels: IList(const ['Design', 'Beta', 'Docs', 'Admin', 'QA'])),
        ),
        _PrimitiveTile(label: 'CmsSwitch', child: CmsSwitch(value: switchOn.value, onChanged: (v) => switchOn.value = v)),
        _PrimitiveTile(
          label: 'CmsCheckRow',
          child: SizedBox(
            width: 180,
            child: CmsCheckRow(label: 'Notify me', selected: checked.value, onTap: () => checked.value = !checked.value),
          ),
        ),
        const _PrimitiveTile(label: 'CmsLoader', child: CmsLoader(size: 20)),
      ],
    );
  }
}

class _PrimitiveTile extends StatelessWidget {
  final String label;
  final Widget child;

  const _PrimitiveTile({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: context.textStyles.caption.copyWith(color: context.colors.hint)),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}

class _TeamMember {
  final String name;
  final String role;
  final bool active;

  const _TeamMember({required this.name, required this.role, required this.active});
}

final IList<_TeamMember> _teamMembers = IList(const [
  _TeamMember(name: 'Ava Chen', role: 'Engineering', active: true),
  _TeamMember(name: 'Liam Ortiz', role: 'Design', active: true),
  _TeamMember(name: 'Noor Haddad', role: 'Engineering', active: false),
  _TeamMember(name: 'Mateo Rossi', role: 'Product', active: true),
  _TeamMember(name: 'Yuki Tanaka', role: 'Engineering', active: true),
  _TeamMember(name: 'Ines Kovac', role: 'Support', active: false),
  _TeamMember(name: 'Owen Baptiste', role: 'Design', active: true),
  _TeamMember(name: 'Priya Nair', role: 'Product', active: true),
  _TeamMember(name: 'Diego Fernandez', role: 'Marketing', active: false),
  _TeamMember(name: 'Sofia Larsen', role: 'Engineering', active: true),
  _TeamMember(name: 'Kwame Asante', role: 'Support', active: true),
  _TeamMember(name: 'Hana Kobayashi', role: 'Design', active: false),
  _TeamMember(name: 'Marcus Webb', role: 'Marketing', active: true),
  _TeamMember(name: 'Elena Popescu', role: 'Product', active: true),
  _TeamMember(name: 'Tariq Malik', role: 'Engineering', active: false),
]);

final IList<CmsTableEntry<_TeamMember>> _teamMemberEntries = IList([
  CmsTableEntry<_TeamMember>(
    id: 'name',
    title: 'Name',
    flex: 3,
    sortBy: (row) => row.name,
    searchBy: (row) => row.name,
    cellBuilder: (context, row) => Text(row.name, style: context.textStyles.text),
  ),
  CmsTableEntry<_TeamMember>(
    id: 'role',
    title: 'Role',
    sortBy: (row) => row.role,
    searchBy: (row) => row.role,
    cellBuilder: (context, row) => Text(row.role, style: context.textStyles.text),
  ),
  CmsTableEntry<_TeamMember>.fixed(
    id: 'active',
    title: 'Status',
    width: 110,
    sortBy: (row) => row.active ? 'Active' : 'Inactive',
    cellBuilder: (context, row) => CmsChip(
      color: row.active ? context.colors.primary.withValues(alpha: 0.12) : context.colors.chipBackground,
      contentColor: row.active ? context.colors.primary : context.colors.hint,
      child: Text(row.active ? 'Active' : 'Inactive'),
    ),
  ),
]);
