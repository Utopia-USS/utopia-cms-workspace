import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:utopia_cms/src/model/entry/cms_entry.dart';
import 'package:utopia_cms/src/model/entry/cms_entry_modifier.dart';
import 'package:utopia_cms/src/ui/widget/layout/cms_page_wrapper.dart';
import 'package:utopia_cms/src/ui/widget/text_field/cms_text_field.dart';
import 'package:utopia_cms/src/util/context_extensions.dart';

/// [CmsEntry] that renders a value as a clickable hyperlink.
///
/// The stored value is either a URL [String], or a `{ 'url': ..., 'name'?: ... }`
/// map whose optional `name` is the visible link text (the URL itself is shown
/// when no name is set). Tapping opens the URL with `url_launcher`, unless a
/// custom [onTap] is supplied. The edit field exposes an optional label and the
/// URL.
class CmsLinkEntry extends CmsEntry<dynamic> {
  CmsLinkEntry({
    required this.key,
    this.label,
    this.onTap,
    this.modifier = const CmsEntryModifier(expanded: true),
    this.flex = 3,
    this.width,
  });

  /// Called with the URL when the link is tapped. Defaults to launching it via
  /// `url_launcher`.
  final void Function(String url)? onTap;

  @override
  final String key;

  @override
  final String? label;

  @override
  final CmsEntryModifier modifier;

  @override
  final int? flex;

  @override
  final double? width;

  static String? _urlOf(dynamic value) => (value is Map ? value['url'] : value) as String?;

  static String? _nameOf(dynamic value) => value is Map ? value['name'] as String? : null;

  void _open(String url) {
    if (onTap != null) {
      onTap!(url);
    } else {
      unawaited(launchUrlString(url));
    }
  }

  @override
  Widget buildPreview(BuildContext context, dynamic value) {
    final url = _urlOf(value);
    if (url == null || url.isEmpty) return const Text('-');
    final name = _nameOf(value);
    final text = (name != null && name.isNotEmpty) ? name : url;
    return _LinkPreview(text: text, onTap: () => _open(url));
  }

  @override
  Widget buildEditField({
    required BuildContext context,
    required dynamic value,
    required void Function(dynamic) onChanged,
  }) {
    final map = value is Map
        ? Map<String, dynamic>.from(value)
        : (value is String && value.isNotEmpty ? <String, dynamic>{'url': value} : <String, dynamic>{});
    final labelField = CmsTextField(
      value: (map['name'] as String?) ?? '',
      onChanged: (v) => onChanged({...map, 'name': (v == null || v.isEmpty) ? null : v}),
      label: Text('$fixedLabel - label (optional)'),
    );
    final urlField = CmsTextField(
      value: (map['url'] as String?) ?? '',
      onChanged: (v) => onChanged({...map, 'url': v ?? ''}),
      label: const Text('URL'),
    );
    // Expanded entry: the label and the URL are two independent fields, each
    // carrying its own field chrome (so no outer wrapper here). They sit side by
    // side filling the full-width row - except on mobile, where the overlay is a
    // single narrow column and the pair stacks vertically instead.
    if (context.pageType.isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [labelField, const SizedBox(height: 12), urlField],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: labelField),
        SizedBox(width: context.theme.fieldContentPadding.left),
        Expanded(child: urlField),
      ],
    );
  }
}

/// Link preview: primary-coloured text with an external-link arrow, underline
/// and arrow brighten on hover, pointer cursor and a link semantics role.
class _LinkPreview extends StatefulWidget {
  const _LinkPreview({required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  State<_LinkPreview> createState() => _LinkPreviewState();
}

class _LinkPreviewState extends State<_LinkPreview> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final color = context.colors.primary;
    final style = context.textStyles.text.copyWith(
      color: color,
      fontWeight: FontWeight.w600,
      decoration: _hovered ? TextDecoration.underline : TextDecoration.none,
      decorationColor: color,
    );
    return Semantics(
      link: true,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(widget.text, overflow: TextOverflow.ellipsis, style: style),
              ),
              const SizedBox(width: 4),
              Icon(Icons.arrow_outward, size: 14, color: color.withValues(alpha: _hovered ? 1.0 : 0.5)),
            ],
          ),
        ),
      ),
    );
  }
}
