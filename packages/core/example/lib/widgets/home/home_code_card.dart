import 'package:flutter/material.dart';

import 'home_hud.dart';
import 'home_showcase_data.dart';

/// A faux code-editor card rendering the [kHeroCodeLines] `CmsTablePage`
/// snippet with light syntax colouring and window chrome.
///
/// It keeps a fixed dark palette across every theme on purpose: a code block is
/// a terminal/editor metaphor, so a dark surface reads as "code" and floats
/// cleanly on each hero gradient (blue, purple, neon, pink) without a contrast
/// gamble.
class HomeCodeCard extends StatelessWidget {
  const HomeCodeCard({super.key});

  static const _bg = Color(0xFF1B1C25);
  static const _bar = Color(0xFF22232F);
  static const _border = Color(0xFF2E2F3D);
  static const _default = Color(0xFFE6E6F0);
  static const _type = Color(0xFF8BE9FD);
  static const _prop = Color(0xFFBD93F9);
  static const _str = Color(0xFFF1FA8C);
  static const _punc = Color(0xFF8A8FA3);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: _bg,
        shape: aurisBevel(16, side: const BorderSide(color: _border, width: 1.5)),
        shadows: const [BoxShadow(color: Color(0x40000000), blurRadius: 24, offset: Offset(0, 12))],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBar(),
          Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 20), child: _buildCode()),
        ],
      ),
    );
  }

  Widget _buildBar() {
    return Container(
      color: _bar,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _dot(const Color(0xFFFF5F57)),
          _dot(const Color(0xFFFEBC2E)),
          _dot(const Color(0xFF28C840)),
          const SizedBox(width: 14),
          const Text(
            'users_page.dart',
            style: TextStyle(color: Color(0xFF9AA0B5), fontSize: 12.5, fontFamily: 'monospace'),
          ),
        ],
      ),
    );
  }

  Widget _dot(Color color) => Container(
    width: 11,
    height: 11,
    margin: const EdgeInsets.only(right: 8),
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );

  Widget _buildCode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final line in kHeroCodeLines)
          Text.rich(
            TextSpan(children: [for (final token in line) _span(token)]),
            style: const TextStyle(fontFamily: 'monospace', fontSize: 13.5, height: 1.75),
          ),
      ],
    );
  }

  /// A token is `role:text`; the role picks the colour. `indent` is raw
  /// whitespace, everything else falls back to [_default].
  TextSpan _span(String token) {
    final i = token.indexOf(':');
    if (i < 0) {
      return TextSpan(
        text: token,
        style: const TextStyle(color: _default),
      );
    }
    final role = token.substring(0, i);
    final text = token.substring(i + 1);
    final color = switch (role) {
      'type' => _type,
      'prop' => _prop,
      'str' => _str,
      'punc' => _punc,
      _ => _default,
    };
    return TextSpan(
      text: text,
      style: TextStyle(color: color),
    );
  }
}
