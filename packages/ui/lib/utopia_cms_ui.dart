/// The design system underlying utopia_cms: general-purpose, CMS-logic-free
/// Flutter components.
library;

// Third-party types appearing in this package's public API surface
// (CmsTable.rows, CmsTableEntry lists, useCmsTableState), re-exported so the
// barrel alone suffices to use them: IList plus the `toIList()` extension.
export 'package:fast_immutable_collections/fast_immutable_collections.dart' show FicIterableExtension, IList;

export 'src/theme/cms_theme.dart';
export 'src/theme/cms_theme_colors.dart';
export 'src/theme/cms_theme_data.dart';
export 'src/theme/cms_theme_text_styles.dart';
export 'src/util/cms_context_extensions.dart';

// utils
/// `DateTime` display-formatting and calendar-arithmetic helpers used by the
/// date picker.
export 'src/util/date_time_extension.dart';

// widgets
export 'src/widget/button/cms_button.dart';
export 'src/widget/button/cms_remove_icon_button.dart';
export 'src/widget/chip/cms_chip.dart';
export 'src/widget/chip/cms_chip_list.dart';
export 'src/widget/date_picker/cms_date_picker.dart';
export 'src/widget/dialog/cms_confirm_dialog.dart';
export 'src/widget/dialog/cms_dialog.dart';
export 'src/widget/dropdown/cms_dropdown_field.dart';
export 'src/widget/layout/cms_breakpoints.dart';
export 'src/widget/layout/cms_card.dart';
export 'src/widget/layout/cms_divider.dart';
export 'src/widget/layout/cms_gradient_background.dart';
export 'src/widget/layout/cms_page_wrapper.dart';
export 'src/widget/loading/cms_loader.dart';
export 'src/widget/loading/cms_mock_loading_box.dart';
export 'src/widget/loading/cms_three_bounce.dart';
export 'src/widget/overlay/cms_overlay_anchor.dart';
export 'src/widget/select/cms_check_row.dart';
export 'src/widget/sidebar/cms_sidebar.dart';
export 'src/widget/sidebar/cms_sidebar_item.dart';
export 'src/widget/switch/cms_switch.dart';
export 'src/widget/switch/cms_switch_field.dart';
export 'src/widget/table/cms_table.dart';
export 'src/widget/table/cms_table_empty.dart';
export 'src/widget/table/cms_table_entry.dart';
export 'src/widget/table/cms_table_search_panel.dart';
export 'src/widget/table/cms_table_state.dart';
export 'src/widget/text/cms_copyable_text.dart';
export 'src/widget/text/cms_title.dart';
export 'src/widget/text_field/cms_search_field.dart';
export 'src/widget/text_field/cms_text_field.dart';
export 'src/widget/wrapper/cms_field_wrapper.dart';
export 'src/widget/wrapper/cms_labeled_field.dart';
