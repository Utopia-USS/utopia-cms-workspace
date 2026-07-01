import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cms_theme_colors.freezed.dart';

@freezed
abstract class CmsThemeColors with _$CmsThemeColors {
  const CmsThemeColors._();

  factory CmsThemeColors({
    required Color primary,
    required Color accent,
    required Color field,
    required Color canvas,
    required Color error,
    required Color disabled,
    required Color text,

    /// Background of the table card and other raised surfaces.
    @Default(Color(0xFFFFFFFF)) Color surface,

    /// Hairline colour for the card border and row / header dividers.
    @Default(Color(0xFFE8EAF0)) Color border,

    /// Tint of alternating (odd) table rows.
    @Default(Color(0xFFF7F8FB)) Color rowAlt,

    /// Row background while hovered.
    @Default(Color(0xFFEFF1F8)) Color hover,

    /// Fill of a `CmsChip`.
    @Default(Color(0xFFE7EAFD)) Color chipBackground,

    /// Content (text / icon) colour of a `CmsChip`.
    @Default(Color(0xFF536DFE)) Color chipForeground,

    /// Muted colour for hints, placeholders and secondary text.
    @Default(Color(0xFF9AA0B5)) Color hint,
  }) = _CmsThemeColors;

  static final CmsThemeColors defaultTheme = CmsThemeColors(
    primary: Colors.indigoAccent[200]!,
    accent: Colors.indigoAccent,
    error: Colors.redAccent,
    field: const Color(0xFFEDEDED),
    canvas: Colors.grey[100]!,
    disabled: Colors.grey[400]!,
    text: Colors.black87,
  );
}
