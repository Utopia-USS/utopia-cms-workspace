import 'package:flutter/material.dart';
import 'package:utopia_cms_ui/src/theme/cms_theme.dart';
import 'package:utopia_cms_ui/src/util/cms_context_extensions.dart';

/// A themed confirm/cancel prompt built on [AlertDialog].
///
/// Generalizes what used to be a CMS-specific "delete item?" dialog into a
/// neutral prefab: no default title/subtitle strings are baked in here -
/// callers own their own copy. Visually this mirrors the previous
/// CMS-specific dialog exactly (title in `textStyles.header`, content capped
/// at 360 logical pixels, text-button actions), so existing call sites keep
/// their look after switching to explicit strings.
class CmsConfirmDialog extends StatelessWidget {
  /// Dialog title, shown in `textStyles.header`.
  final String title;

  /// Optional body copy, shown in `textStyles.text` inside a 360-wide box.
  /// When null, the dialog renders with no content section.
  final String? subtitle;

  /// Label of the confirming action button.
  final String confirmLabel;

  /// Label of the cancelling action button.
  final String cancelLabel;

  /// Whether the confirming action button is shown.
  final bool hasConfirm;

  /// Whether the cancelling action button is shown.
  final bool hasCancel;

  /// Creates a confirm dialog. Use [show] to present it as a route.
  const CmsConfirmDialog({
    super.key,
    required this.title,
    this.subtitle,
    this.confirmLabel = 'Proceed',
    this.cancelLabel = 'Cancel',
    this.hasConfirm = true,
    this.hasCancel = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final texts = context.textStyles;
    final subtitle = this.subtitle;
    return AlertDialog(
      title: Text(title, style: texts.header),
      buttonPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      content: subtitle == null ? null : SizedBox(width: 360, child: Text(subtitle, style: texts.text)),
      actions: [
        if (hasCancel)
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelLabel, style: texts.label.copyWith(color: colors.primary)),
          ),
        if (hasConfirm)
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmLabel, style: texts.label),
          ),
      ],
    );
  }

  /// Thin wrapper over vanilla [showDialog]: captures [CmsTheme.of] from
  /// [context] and re-attaches it inside the route (the dialog Navigator sits
  /// outside any `CmsTheme` ancestor), then builds a [CmsConfirmDialog] with
  /// the given parameters. Resolves to `true`/`false` depending on which
  /// action was pressed, or `null` if the dialog was dismissed unanswered.
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    String? subtitle,
    String confirmLabel = 'Proceed',
    String cancelLabel = 'Cancel',
    bool hasConfirm = true,
    bool hasCancel = true,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (_) => CmsTheme.captured(
        context,
        child: CmsConfirmDialog(
          title: title,
          subtitle: subtitle,
          confirmLabel: confirmLabel,
          cancelLabel: cancelLabel,
          hasConfirm: hasConfirm,
          hasCancel: hasCancel,
        ),
      ),
    );
  }
}
