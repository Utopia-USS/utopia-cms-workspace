// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cms_theme_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CmsThemeData {

 CmsThemeColors get colors; CmsThemeTextStyles get textStyles; BorderRadius get borderRadius; EdgeInsets get fieldContentPadding; double get pageTopPadding; List<BoxShadow> get menuShadow; BorderRadius get menuRadius; double get shortButtonWidth;/// Corner radius of the table card.
 BorderRadius get cardRadius;/// Stroke width of the table card border.
 double get cardBorderWidth;/// Drop shadow cast by the table card.
 List<BoxShadow> get cardShadow;/// Height of a single table row.
 double get tileHeight;/// Thickness of row / header dividers.
 double get dividerThickness;/// Corner radius of a `CmsChip`.
 double get chipRadius;
/// Create a copy of CmsThemeData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CmsThemeDataCopyWith<CmsThemeData> get copyWith => _$CmsThemeDataCopyWithImpl<CmsThemeData>(this as CmsThemeData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CmsThemeData&&(identical(other.colors, colors) || other.colors == colors)&&(identical(other.textStyles, textStyles) || other.textStyles == textStyles)&&(identical(other.borderRadius, borderRadius) || other.borderRadius == borderRadius)&&(identical(other.fieldContentPadding, fieldContentPadding) || other.fieldContentPadding == fieldContentPadding)&&(identical(other.pageTopPadding, pageTopPadding) || other.pageTopPadding == pageTopPadding)&&const DeepCollectionEquality().equals(other.menuShadow, menuShadow)&&(identical(other.menuRadius, menuRadius) || other.menuRadius == menuRadius)&&(identical(other.shortButtonWidth, shortButtonWidth) || other.shortButtonWidth == shortButtonWidth)&&(identical(other.cardRadius, cardRadius) || other.cardRadius == cardRadius)&&(identical(other.cardBorderWidth, cardBorderWidth) || other.cardBorderWidth == cardBorderWidth)&&const DeepCollectionEquality().equals(other.cardShadow, cardShadow)&&(identical(other.tileHeight, tileHeight) || other.tileHeight == tileHeight)&&(identical(other.dividerThickness, dividerThickness) || other.dividerThickness == dividerThickness)&&(identical(other.chipRadius, chipRadius) || other.chipRadius == chipRadius));
}


@override
int get hashCode => Object.hash(runtimeType,colors,textStyles,borderRadius,fieldContentPadding,pageTopPadding,const DeepCollectionEquality().hash(menuShadow),menuRadius,shortButtonWidth,cardRadius,cardBorderWidth,const DeepCollectionEquality().hash(cardShadow),tileHeight,dividerThickness,chipRadius);

@override
String toString() {
  return 'CmsThemeData(colors: $colors, textStyles: $textStyles, borderRadius: $borderRadius, fieldContentPadding: $fieldContentPadding, pageTopPadding: $pageTopPadding, menuShadow: $menuShadow, menuRadius: $menuRadius, shortButtonWidth: $shortButtonWidth, cardRadius: $cardRadius, cardBorderWidth: $cardBorderWidth, cardShadow: $cardShadow, tileHeight: $tileHeight, dividerThickness: $dividerThickness, chipRadius: $chipRadius)';
}


}

/// @nodoc
abstract mixin class $CmsThemeDataCopyWith<$Res>  {
  factory $CmsThemeDataCopyWith(CmsThemeData value, $Res Function(CmsThemeData) _then) = _$CmsThemeDataCopyWithImpl;
@useResult
$Res call({
 CmsThemeColors colors, CmsThemeTextStyles textStyles, BorderRadius borderRadius, EdgeInsets fieldContentPadding, double pageTopPadding, List<BoxShadow> menuShadow, BorderRadius menuRadius, double shortButtonWidth, BorderRadius cardRadius, double cardBorderWidth, List<BoxShadow> cardShadow, double tileHeight, double dividerThickness, double chipRadius
});


$CmsThemeColorsCopyWith<$Res> get colors;$CmsThemeTextStylesCopyWith<$Res> get textStyles;

}
/// @nodoc
class _$CmsThemeDataCopyWithImpl<$Res>
    implements $CmsThemeDataCopyWith<$Res> {
  _$CmsThemeDataCopyWithImpl(this._self, this._then);

  final CmsThemeData _self;
  final $Res Function(CmsThemeData) _then;

/// Create a copy of CmsThemeData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? colors = null,Object? textStyles = null,Object? borderRadius = null,Object? fieldContentPadding = null,Object? pageTopPadding = null,Object? menuShadow = null,Object? menuRadius = null,Object? shortButtonWidth = null,Object? cardRadius = null,Object? cardBorderWidth = null,Object? cardShadow = null,Object? tileHeight = null,Object? dividerThickness = null,Object? chipRadius = null,}) {
  return _then(_self.copyWith(
colors: null == colors ? _self.colors : colors // ignore: cast_nullable_to_non_nullable
as CmsThemeColors,textStyles: null == textStyles ? _self.textStyles : textStyles // ignore: cast_nullable_to_non_nullable
as CmsThemeTextStyles,borderRadius: null == borderRadius ? _self.borderRadius : borderRadius // ignore: cast_nullable_to_non_nullable
as BorderRadius,fieldContentPadding: null == fieldContentPadding ? _self.fieldContentPadding : fieldContentPadding // ignore: cast_nullable_to_non_nullable
as EdgeInsets,pageTopPadding: null == pageTopPadding ? _self.pageTopPadding : pageTopPadding // ignore: cast_nullable_to_non_nullable
as double,menuShadow: null == menuShadow ? _self.menuShadow : menuShadow // ignore: cast_nullable_to_non_nullable
as List<BoxShadow>,menuRadius: null == menuRadius ? _self.menuRadius : menuRadius // ignore: cast_nullable_to_non_nullable
as BorderRadius,shortButtonWidth: null == shortButtonWidth ? _self.shortButtonWidth : shortButtonWidth // ignore: cast_nullable_to_non_nullable
as double,cardRadius: null == cardRadius ? _self.cardRadius : cardRadius // ignore: cast_nullable_to_non_nullable
as BorderRadius,cardBorderWidth: null == cardBorderWidth ? _self.cardBorderWidth : cardBorderWidth // ignore: cast_nullable_to_non_nullable
as double,cardShadow: null == cardShadow ? _self.cardShadow : cardShadow // ignore: cast_nullable_to_non_nullable
as List<BoxShadow>,tileHeight: null == tileHeight ? _self.tileHeight : tileHeight // ignore: cast_nullable_to_non_nullable
as double,dividerThickness: null == dividerThickness ? _self.dividerThickness : dividerThickness // ignore: cast_nullable_to_non_nullable
as double,chipRadius: null == chipRadius ? _self.chipRadius : chipRadius // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of CmsThemeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CmsThemeColorsCopyWith<$Res> get colors {
  
  return $CmsThemeColorsCopyWith<$Res>(_self.colors, (value) {
    return _then(_self.copyWith(colors: value));
  });
}/// Create a copy of CmsThemeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CmsThemeTextStylesCopyWith<$Res> get textStyles {
  
  return $CmsThemeTextStylesCopyWith<$Res>(_self.textStyles, (value) {
    return _then(_self.copyWith(textStyles: value));
  });
}
}


/// Adds pattern-matching-related methods to [CmsThemeData].
extension CmsThemeDataPatterns on CmsThemeData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CmsThemeData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CmsThemeData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CmsThemeData value)  $default,){
final _that = this;
switch (_that) {
case _CmsThemeData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CmsThemeData value)?  $default,){
final _that = this;
switch (_that) {
case _CmsThemeData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CmsThemeColors colors,  CmsThemeTextStyles textStyles,  BorderRadius borderRadius,  EdgeInsets fieldContentPadding,  double pageTopPadding,  List<BoxShadow> menuShadow,  BorderRadius menuRadius,  double shortButtonWidth,  BorderRadius cardRadius,  double cardBorderWidth,  List<BoxShadow> cardShadow,  double tileHeight,  double dividerThickness,  double chipRadius)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CmsThemeData() when $default != null:
return $default(_that.colors,_that.textStyles,_that.borderRadius,_that.fieldContentPadding,_that.pageTopPadding,_that.menuShadow,_that.menuRadius,_that.shortButtonWidth,_that.cardRadius,_that.cardBorderWidth,_that.cardShadow,_that.tileHeight,_that.dividerThickness,_that.chipRadius);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CmsThemeColors colors,  CmsThemeTextStyles textStyles,  BorderRadius borderRadius,  EdgeInsets fieldContentPadding,  double pageTopPadding,  List<BoxShadow> menuShadow,  BorderRadius menuRadius,  double shortButtonWidth,  BorderRadius cardRadius,  double cardBorderWidth,  List<BoxShadow> cardShadow,  double tileHeight,  double dividerThickness,  double chipRadius)  $default,) {final _that = this;
switch (_that) {
case _CmsThemeData():
return $default(_that.colors,_that.textStyles,_that.borderRadius,_that.fieldContentPadding,_that.pageTopPadding,_that.menuShadow,_that.menuRadius,_that.shortButtonWidth,_that.cardRadius,_that.cardBorderWidth,_that.cardShadow,_that.tileHeight,_that.dividerThickness,_that.chipRadius);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CmsThemeColors colors,  CmsThemeTextStyles textStyles,  BorderRadius borderRadius,  EdgeInsets fieldContentPadding,  double pageTopPadding,  List<BoxShadow> menuShadow,  BorderRadius menuRadius,  double shortButtonWidth,  BorderRadius cardRadius,  double cardBorderWidth,  List<BoxShadow> cardShadow,  double tileHeight,  double dividerThickness,  double chipRadius)?  $default,) {final _that = this;
switch (_that) {
case _CmsThemeData() when $default != null:
return $default(_that.colors,_that.textStyles,_that.borderRadius,_that.fieldContentPadding,_that.pageTopPadding,_that.menuShadow,_that.menuRadius,_that.shortButtonWidth,_that.cardRadius,_that.cardBorderWidth,_that.cardShadow,_that.tileHeight,_that.dividerThickness,_that.chipRadius);case _:
  return null;

}
}

}

/// @nodoc


class _CmsThemeData extends CmsThemeData {
  const _CmsThemeData({required this.colors, required this.textStyles, required this.borderRadius, required this.fieldContentPadding, required this.pageTopPadding, required final  List<BoxShadow> menuShadow, required this.menuRadius, required this.shortButtonWidth, this.cardRadius = const BorderRadius.all(Radius.circular(16)), this.cardBorderWidth = 1.5, final  List<BoxShadow> cardShadow = const <BoxShadow>[BoxShadow(color: Color(0x0D000000), blurRadius: 6, offset: Offset(0, 1))], this.tileHeight = 58.0, this.dividerThickness = 1.0, this.chipRadius = 8.0}): _menuShadow = menuShadow,_cardShadow = cardShadow,super._();
  

@override final  CmsThemeColors colors;
@override final  CmsThemeTextStyles textStyles;
@override final  BorderRadius borderRadius;
@override final  EdgeInsets fieldContentPadding;
@override final  double pageTopPadding;
 final  List<BoxShadow> _menuShadow;
@override List<BoxShadow> get menuShadow {
  if (_menuShadow is EqualUnmodifiableListView) return _menuShadow;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_menuShadow);
}

@override final  BorderRadius menuRadius;
@override final  double shortButtonWidth;
/// Corner radius of the table card.
@override@JsonKey() final  BorderRadius cardRadius;
/// Stroke width of the table card border.
@override@JsonKey() final  double cardBorderWidth;
/// Drop shadow cast by the table card.
 final  List<BoxShadow> _cardShadow;
/// Drop shadow cast by the table card.
@override@JsonKey() List<BoxShadow> get cardShadow {
  if (_cardShadow is EqualUnmodifiableListView) return _cardShadow;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cardShadow);
}

/// Height of a single table row.
@override@JsonKey() final  double tileHeight;
/// Thickness of row / header dividers.
@override@JsonKey() final  double dividerThickness;
/// Corner radius of a `CmsChip`.
@override@JsonKey() final  double chipRadius;

/// Create a copy of CmsThemeData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CmsThemeDataCopyWith<_CmsThemeData> get copyWith => __$CmsThemeDataCopyWithImpl<_CmsThemeData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CmsThemeData&&(identical(other.colors, colors) || other.colors == colors)&&(identical(other.textStyles, textStyles) || other.textStyles == textStyles)&&(identical(other.borderRadius, borderRadius) || other.borderRadius == borderRadius)&&(identical(other.fieldContentPadding, fieldContentPadding) || other.fieldContentPadding == fieldContentPadding)&&(identical(other.pageTopPadding, pageTopPadding) || other.pageTopPadding == pageTopPadding)&&const DeepCollectionEquality().equals(other._menuShadow, _menuShadow)&&(identical(other.menuRadius, menuRadius) || other.menuRadius == menuRadius)&&(identical(other.shortButtonWidth, shortButtonWidth) || other.shortButtonWidth == shortButtonWidth)&&(identical(other.cardRadius, cardRadius) || other.cardRadius == cardRadius)&&(identical(other.cardBorderWidth, cardBorderWidth) || other.cardBorderWidth == cardBorderWidth)&&const DeepCollectionEquality().equals(other._cardShadow, _cardShadow)&&(identical(other.tileHeight, tileHeight) || other.tileHeight == tileHeight)&&(identical(other.dividerThickness, dividerThickness) || other.dividerThickness == dividerThickness)&&(identical(other.chipRadius, chipRadius) || other.chipRadius == chipRadius));
}


@override
int get hashCode => Object.hash(runtimeType,colors,textStyles,borderRadius,fieldContentPadding,pageTopPadding,const DeepCollectionEquality().hash(_menuShadow),menuRadius,shortButtonWidth,cardRadius,cardBorderWidth,const DeepCollectionEquality().hash(_cardShadow),tileHeight,dividerThickness,chipRadius);

@override
String toString() {
  return 'CmsThemeData(colors: $colors, textStyles: $textStyles, borderRadius: $borderRadius, fieldContentPadding: $fieldContentPadding, pageTopPadding: $pageTopPadding, menuShadow: $menuShadow, menuRadius: $menuRadius, shortButtonWidth: $shortButtonWidth, cardRadius: $cardRadius, cardBorderWidth: $cardBorderWidth, cardShadow: $cardShadow, tileHeight: $tileHeight, dividerThickness: $dividerThickness, chipRadius: $chipRadius)';
}


}

/// @nodoc
abstract mixin class _$CmsThemeDataCopyWith<$Res> implements $CmsThemeDataCopyWith<$Res> {
  factory _$CmsThemeDataCopyWith(_CmsThemeData value, $Res Function(_CmsThemeData) _then) = __$CmsThemeDataCopyWithImpl;
@override @useResult
$Res call({
 CmsThemeColors colors, CmsThemeTextStyles textStyles, BorderRadius borderRadius, EdgeInsets fieldContentPadding, double pageTopPadding, List<BoxShadow> menuShadow, BorderRadius menuRadius, double shortButtonWidth, BorderRadius cardRadius, double cardBorderWidth, List<BoxShadow> cardShadow, double tileHeight, double dividerThickness, double chipRadius
});


@override $CmsThemeColorsCopyWith<$Res> get colors;@override $CmsThemeTextStylesCopyWith<$Res> get textStyles;

}
/// @nodoc
class __$CmsThemeDataCopyWithImpl<$Res>
    implements _$CmsThemeDataCopyWith<$Res> {
  __$CmsThemeDataCopyWithImpl(this._self, this._then);

  final _CmsThemeData _self;
  final $Res Function(_CmsThemeData) _then;

/// Create a copy of CmsThemeData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? colors = null,Object? textStyles = null,Object? borderRadius = null,Object? fieldContentPadding = null,Object? pageTopPadding = null,Object? menuShadow = null,Object? menuRadius = null,Object? shortButtonWidth = null,Object? cardRadius = null,Object? cardBorderWidth = null,Object? cardShadow = null,Object? tileHeight = null,Object? dividerThickness = null,Object? chipRadius = null,}) {
  return _then(_CmsThemeData(
colors: null == colors ? _self.colors : colors // ignore: cast_nullable_to_non_nullable
as CmsThemeColors,textStyles: null == textStyles ? _self.textStyles : textStyles // ignore: cast_nullable_to_non_nullable
as CmsThemeTextStyles,borderRadius: null == borderRadius ? _self.borderRadius : borderRadius // ignore: cast_nullable_to_non_nullable
as BorderRadius,fieldContentPadding: null == fieldContentPadding ? _self.fieldContentPadding : fieldContentPadding // ignore: cast_nullable_to_non_nullable
as EdgeInsets,pageTopPadding: null == pageTopPadding ? _self.pageTopPadding : pageTopPadding // ignore: cast_nullable_to_non_nullable
as double,menuShadow: null == menuShadow ? _self._menuShadow : menuShadow // ignore: cast_nullable_to_non_nullable
as List<BoxShadow>,menuRadius: null == menuRadius ? _self.menuRadius : menuRadius // ignore: cast_nullable_to_non_nullable
as BorderRadius,shortButtonWidth: null == shortButtonWidth ? _self.shortButtonWidth : shortButtonWidth // ignore: cast_nullable_to_non_nullable
as double,cardRadius: null == cardRadius ? _self.cardRadius : cardRadius // ignore: cast_nullable_to_non_nullable
as BorderRadius,cardBorderWidth: null == cardBorderWidth ? _self.cardBorderWidth : cardBorderWidth // ignore: cast_nullable_to_non_nullable
as double,cardShadow: null == cardShadow ? _self._cardShadow : cardShadow // ignore: cast_nullable_to_non_nullable
as List<BoxShadow>,tileHeight: null == tileHeight ? _self.tileHeight : tileHeight // ignore: cast_nullable_to_non_nullable
as double,dividerThickness: null == dividerThickness ? _self.dividerThickness : dividerThickness // ignore: cast_nullable_to_non_nullable
as double,chipRadius: null == chipRadius ? _self.chipRadius : chipRadius // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of CmsThemeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CmsThemeColorsCopyWith<$Res> get colors {
  
  return $CmsThemeColorsCopyWith<$Res>(_self.colors, (value) {
    return _then(_self.copyWith(colors: value));
  });
}/// Create a copy of CmsThemeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CmsThemeTextStylesCopyWith<$Res> get textStyles {
  
  return $CmsThemeTextStylesCopyWith<$Res>(_self.textStyles, (value) {
    return _then(_self.copyWith(textStyles: value));
  });
}
}

// dart format on
