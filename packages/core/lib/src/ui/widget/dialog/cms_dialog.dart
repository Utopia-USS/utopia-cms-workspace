import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utopia_cms/src/theme/cms_theme_data.dart';
import 'package:utopia_cms/src/util/context_extensions.dart';

class CmsDialog extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final bool hasProceed;
  final bool hasCancel;

  const CmsDialog({super.key, this.title, this.subtitle, this.hasCancel = true, this.hasProceed = true});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final texts = context.textStyles;
    return AlertDialog(
      title: Text(title ?? "Delete item", style: texts.header),
      buttonPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      content: SizedBox(
        width: 360,
        child: Text(
          subtitle ?? "Are you sure you want to delete this item? You cannot undo this action.",
          style: texts.text,
        ),
      ),
      actions: [
        if (hasCancel)
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text("Cancel", style: texts.label.copyWith(color: colors.primary)),
          ),
        if (hasProceed)
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text("Proceed", style: texts.label),
          ),
      ],
    );
  }

  static Future<bool?> show(
    BuildContext context, {
    String? title,
    String? subtitle,
    bool hasProceed = true,
    bool hasCancel = true,
  }) async {
    // showDialog roots at the app Navigator, outside the CmsWidget theme
    // provider, so capture the resolved theme and re-provide it in the dialog.
    final theme = Provider.of<CmsThemeData?>(context, listen: false) ?? CmsThemeData.defaultTheme;
    return showDialog<bool>(
      context: context,
      builder: (_) => Provider.value(
        value: theme,
        child: CmsDialog(title: title, subtitle: subtitle, hasProceed: hasProceed, hasCancel: hasCancel),
      ),
    );
  }
}
