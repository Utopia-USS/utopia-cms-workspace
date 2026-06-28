import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:utopia_cms/utopia_cms.dart';

/// Custom media entry backed by a fixed gallery of generated SVGs.
///
/// Stores a gallery key (e.g. `'octopus'`) and renders the matching SVG. The
/// edit field is a picker over the gallery - the demo's stand-in for a real
/// upload backend. Used for both the spirit animals (Libs) and the impact
/// badges (Skills). Renders on every platform because flutter_svg rasterises
/// the SVG itself (the stock CmsMediaEntry renders via Image.network).
class SvgMediaEntry extends CmsEntry<String?> {
  SvgMediaEntry({
    required this.key,
    required this.gallery,
    required this.labels,
    this.label,
    this.modifier = const CmsEntryModifier(expanded: true, required: false),
    this.flex = 1,
    this.width,
  });

  final Map<String, String> gallery;
  final Map<String, String> labels;

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

  @override
  Widget buildPreview(BuildContext context, String? value) {
    final svg = value == null ? null : gallery[value];
    if (svg == null) return const Text('-');
    return SvgPicture.string(svg, width: 40, height: 40);
  }

  @override
  Widget buildEditField({
    required BuildContext context,
    required String? value,
    required void Function(String?) onChanged,
  }) {
    final accent = Theme.of(context).colorScheme.primary;
    return CmsFieldWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(fixedLabelRequired, style: Theme.of(context).textTheme.bodyMedium),
          ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final e in gallery.entries)
                _Tile(
                  svg: e.value,
                  label: labels[e.key] ?? e.key,
                  selected: e.key == value,
                  accent: accent,
                  onTap: () => onChanged(e.key),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.svg,
    required this.label,
    required this.selected,
    required this.accent,
    required this.onTap,
  });

  final String svg;
  final String label;
  final bool selected;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 84,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: selected ? accent : Colors.black12, width: selected ? 2.5 : 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.string(svg, width: 52, height: 52),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
