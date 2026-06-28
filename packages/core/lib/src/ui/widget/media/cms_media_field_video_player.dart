import 'package:flutter/material.dart';
import 'package:utopia_cms/utopia_cms.dart';

class CmsMediaFieldVideoPlayer extends StatelessWidget {
  final String url;
  final double size;

  const CmsMediaFieldVideoPlayer({super.key, required this.url, required this.size});

  @override
  Widget build(BuildContext context) {
    return CmsVideoPlayer(
      previewOnly: true,
      url: url,
      playerBuilder: (naturalSize, player) {
        return SizedBox.square(
          dimension: size,
          child: FittedBox(fit: BoxFit.cover, clipBehavior: Clip.hardEdge, child: player),
        );
      },
    );
  }
}
