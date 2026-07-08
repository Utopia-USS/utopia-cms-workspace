import 'package:flutter/material.dart';
import 'package:utopia_cms/src/delegate/cms_delegate.dart';
import 'package:utopia_cms/src/model/entry/cms_entry.dart';
import 'package:utopia_cms/src/model/filter_entry/cms_filter_entry.dart';
import 'package:utopia_cms/src/model/item_management/cms_management_section_entry.dart';
import 'package:utopia_cms/src/model/table/cms_table_action.dart';
import 'package:utopia_cms/src/model/table/cms_table_page_params.dart';
import 'package:utopia_cms/src/ui/table_page/state/cms_table_page_state.dart';
import 'package:utopia_cms/src/ui/table_page/view/cms_table_page_view.dart';
import 'package:utopia_cms/src/util/foundation.dart';
import 'package:utopia_cms_ui/utopia_cms_ui.dart';

///  * [CmsTablePage] by default is able to generate complete flow of data table preview, creation/edition flow.
class CmsTablePage extends HookWidget {
  final CmsDelegate delegate;
  final CmsTableParams params;
  final String title;
  final List<CmsEntry<dynamic>> entries;
  final List<CmsFilterEntry<dynamic>>? filterEntries;
  final List<CmsTableAction>? customActions;
  final int? pagingLimit;
  final List<CmsManagementSectionEntry> managementSectionEntries;

  const CmsTablePage({
    super.key,
    required this.delegate,
    required this.title,
    this.params = CmsTableParams.defaultParams,
    required this.entries,
    this.customActions,
    this.filterEntries,
    this.managementSectionEntries = const [],
    this.pagingLimit = 30,
  }) : assert(pagingLimit != 0);

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final lockedEntries = entries.lock;
    final lockedFilterEntries = (filterEntries ?? []).lock;
    final state = useCmsTablePageState(
      delegate: delegate,
      params: params,
      navigator: navigator,
      entries: lockedEntries,
      filterEntries: lockedFilterEntries,
      confirmDelete: () async => CmsConfirmDialog.show(
        context,
        title: 'Delete item',
        subtitle: 'Are you sure you want to delete this item? You cannot undo this action.',
      ),
      pagingLimit: pagingLimit,
      managementSectionEntries: managementSectionEntries,
    );
    return CmsPageWrapper(
      builder: (context, _) => CmsTablePageView(
        state: state,
        entries: lockedEntries,
        filterEntries: lockedFilterEntries,
        title: title,
        customActions: (customActions ?? []).lock,
      ),
    );
  }
}
