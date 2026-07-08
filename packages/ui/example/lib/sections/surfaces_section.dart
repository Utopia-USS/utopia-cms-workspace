import 'package:flutter/material.dart';
import 'package:utopia_cms_ui/utopia_cms_ui.dart';

import '../widgets/section.dart';

/// Cards, field chrome, gradients and hairlines - the shells everything else
/// in the design system sits inside.
class SurfacesSection extends StatelessWidget {
  /// Creates the surfaces and shape section.
  const SurfacesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textStyles = context.textStyles;
    return SheetSection(
      title: 'Surfaces & shape',
      subtitle: 'Cards, field chrome, gradients and hairlines - the shells everything else sits in.',
      child: Wrap(
        spacing: 32,
        runSpacing: 24,
        children: [
          SpecimenTile(
            label: 'CmsCard',
            panel: false,
            child: SizedBox(
              width: 240,
              child: CmsCard(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Raised surface', style: textStyles.label),
                      const SizedBox(height: 6),
                      Text(
                        'cardRadius + cardShadow + hairline border',
                        style: textStyles.caption.copyWith(color: context.colors.hint),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SpecimenTile(
            label: 'CmsFieldWrapper (field chrome)',
            width: 240,
            panel: false,
            child: CmsLabeledField(label: 'Field chrome', value: 'Shared by every field'),
          ),
          SpecimenTile(
            label: 'CmsGradientBackground',
            panel: false,
            child: ClipRRect(
              borderRadius: theme.borderRadius,
              child: SizedBox(
                width: 160,
                height: 56,
                child: CmsGradientBackground(
                  child: Center(child: Text('primary -> accent', style: textStyles.button)),
                ),
              ),
            ),
          ),
          SpecimenTile(
            label: 'Disabled gradient',
            panel: false,
            child: ClipRRect(
              borderRadius: theme.borderRadius,
              child: SizedBox(
                width: 160,
                height: 56,
                child: CmsGradientBackground(
                  isEnabled: false,
                  child: Center(child: Text('disabled', style: textStyles.button)),
                ),
              ),
            ),
          ),
          const SpecimenTile(
            label: 'CmsDivider',
            panel: false,
            child: SizedBox(width: 240, child: CmsDivider()),
          ),
        ],
      ),
    );
  }
}
