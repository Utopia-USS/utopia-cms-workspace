import 'package:flutter/material.dart';
import 'package:utopia_cms_ui/utopia_cms_ui.dart';

import '../widgets/section.dart';

/// Spinners, bouncing dots and shimmer skeletons.
class LoadingSection extends StatelessWidget {
  /// Creates the loading section.
  const LoadingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SheetSection(
      title: 'Loading',
      subtitle: 'Spinners, bouncing dots and shimmer skeletons.',
      child: Wrap(
        spacing: 32,
        runSpacing: 24,
        children: [
          const SpecimenTile(
            label: 'CmsLoader 12 / 20 / 32',
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CmsLoader(),
                SizedBox(width: 24),
                CmsLoader(size: 20),
                SizedBox(width: 24),
                CmsLoader(size: 32),
              ],
            ),
          ),
          const SpecimenTile(label: 'CmsThreeBounce', child: CmsThreeBounce()),
          SpecimenTile(
            label: 'CmsThreeBounce - primary',
            child: CmsThreeBounce(color: colors.primary),
          ),
          const SpecimenTile(
            label: 'Skeleton (CmsMockLoadingBox)',
            child: SizedBox(
              width: 280,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CmsMockLoadingBox(height: 12, width: 140),
                  SizedBox(height: 12),
                  CmsMockLoadingBox(height: 8, width: 220),
                  SizedBox(height: 8),
                  CmsMockLoadingBox(height: 8, width: 180),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
