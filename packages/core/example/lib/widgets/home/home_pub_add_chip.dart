import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:utopia_cms/utopia_cms.dart';

import 'home_hud.dart';
import 'home_showcase_data.dart';

/// The `flutter pub add utopia_cms` install command as a copyable chip.
///
/// Rendered on the gradient bands (hero + closing CTA), so it draws on the
/// passed [onColor] (the band's foreground) over a translucent wash of it -
/// staying legible on any theme's gradient. Tapping copies the command.
class HomePubAddChip extends StatefulWidget {
  final CmsThemeData theme;
  final Color onColor;

  const HomePubAddChip({super.key, required this.theme, required this.onColor});

  @override
  State<HomePubAddChip> createState() => _HomePubAddChipState();
}

class _HomePubAddChipState extends State<HomePubAddChip> {
  bool _copied = false;

  Future<void> _copy() async {
    await Clipboard.setData(const ClipboardData(text: kPubAddCommand));
    if (mounted) setState(() => _copied = true);
  }

  @override
  Widget build(BuildContext context) {
    final onColor = widget.onColor;
    final shape = aurisBevel(8);
    return Material(
      color: onColor.withValues(alpha: 0.14),
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _copy,
        customBorder: shape,
        hoverColor: onColor.withValues(alpha: 0.22),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                r'$',
                style: TextStyle(color: onColor.withValues(alpha: 0.6), fontFamily: 'monospace', fontSize: 14),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  kPubAddCommand,
                  style: TextStyle(color: onColor, fontFamily: 'monospace', fontSize: 14, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 14),
              Icon(_copied ? Icons.check_rounded : Icons.copy_rounded, size: 16, color: onColor.withValues(alpha: 0.8)),
            ],
          ),
        ),
      ),
    );
  }
}
