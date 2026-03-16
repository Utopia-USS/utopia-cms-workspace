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

 CmsThemeColors get colors; CmsThemeTextStyles get textStyles; BorderRadius get borderRadius; EdgeInsets get fieldContentPadding; double get pageTopPadding; List<BoxShadow> get menuShadow; BorderRadius get menuRadius; double get shortButtonWidth;
/// Create a copy of CmsThemeData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CmsThemeDataCopyWith<CmsThemeData> get copyWith => _$CmsThemeDataCopyWithImpl<CmsThemeData>(this as CmsThemeData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CmsThemeData&&(identical(other.colors, colors) || other.colors == colors)&&(identical(other.textStyles, textStyles) || other.textStyles == textStyles)&&(identical(other.borderRadius, borderRadius) || other.borderRadius == borderRadius)&&(identical(other.fieldContentPadding, fieldContentPadding) || other.fieldContentPadding == fieldContentPadding)&&(identical(other.pageTopPadding, pageTopPadding) || other.pageTopPadding == pageTopPadding)&&const DeepCollectionEquality().equals(other.menuShadow, menuShadow)&&(identical(other.menuRadius, menuRadius) || other.menuRadius == menuRadius)&&(identical(other.shortButtonWidth, shortButtonWidth) || other.shortButtonWidth == shortButtonWidth));
}


@override
int get hashCode => Object.hash(runtimeType,colors,textStyles,borderRadius,fieldContentPadding,pageTopPadding,const DeepCollectionEquality().hash(menuShadow),menuRadius,shortButtonWidth);

@override
String toString() {
  return 'CmsThemeData(colors: $colors, textStyles: $textStyles, borderRadius: $borderRadius, fieldContentPadding: $fieldContentPadding, pageTopPadding: $pageTopPadding, menuShadow: $menuShadow, menuRadius: $menuRadius, shortButtonWidth: $shortButtonWidth)';
}


}

/// @nodoc
abstract mixin class $CmsThemeDataCopyWith<$Res>  {
  factory $CmsThemeDataCopyWith(CmsThemeData value, $Res Function(CmsThemeData) _then) = _$CmsThemeDataCopyWithImpl;
@useResult
$Res call({
 CmsThemeColors colors, CmsThemeTextStyles textStyles, BorderRadius borderRadius, EdgeInsets fieldContentPadding, double pageTopPadding, List<BoxShadow> menuShadow, BorderRadius menuRadius, double shortButtonWidth
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
@pragma('vm:prefer-inline') @override $Res call({Object? colors = null,Object? textStyles = null,Object? borderRadius = null,Object? fieldContentPadding = null,Object? pageTopPadding = null,Object? menuShadow = null,Object? menuRadius = null,Object? shortButtonWidth = null,}) {
  return _then(_self.copyWith(
colors: null == colors ? _self.colors : colors // ignore: cast_nullable_to_non_nullable
as CmsThemeColors,textStyles: null == textStyles ? _self.textStyles : textStyles // ignore: cast_nullable_to_non_nullable
as CmsThemeTextStyles,borderRadius: null == borderRadius ? _self.borderRadius : borderRadius // ignore: cast_nullable_to_non_nullable
as BorderRadius,fieldContentPadding: null == fieldContentPadding ? _self.fieldContentPadding : fieldContentPadding // ignore: cast_nullable_to_non_nullable
as EdgeInsets,pageTopPadding: null == pageTopPadding ? _self.pageTopPadding : pageTopPadding // ignore: cast_nullable_to_non_nullable
as double,menuShadow: null == menuShadow ? _self.menuShadow : menuShadow // ignore: cast_nullable_to_non_nullable
as List<BoxShadow>,menuRadius: null == menuRadius ? _self.menuRadius : menuRadius // ignore: cast_nullable_to_non_nullable
as BorderRadius,shortButtonWidth: null == shortButtonWidth ? _self.shortButtonWidth : shortButtonWidth // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CmsThemeColors colors,  CmsThemeTextStyles textStyles,  BorderRadius borderRadius,  EdgeInsets fieldContentPadding,  double pageTopPadding,  List<BoxShadow> menuShadow,  BorderRadius menuRadius,  double shortButtonWidth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CmsThemeData() when $default != null:
return $default(_that.colors,_that.textStyles,_that.borderRadius,_that.fieldContentPadding,_that.pageTopPadding,_that.menuShadow,_that.menuRadius,_that.shortButtonWidth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CmsThemeColors colors,  CmsThemeTextStyles textStyles,  BorderRadius borderRadius,  EdgeInsets fieldContentPadding,  double pageTopPadding,  List<BoxShadow> menuShadow,  BorderRadius menuRadius,  double shortButtonWidth)  $default,) {final _that = this;
switch (_that) {
case _CmsThemeData():
return $default(_that.colors,_that.textStyles,_that.borderRadius,_that.fieldContentPadding,_that.pageTopPadding,_that.menuShadow,_that.menuRadius,_that.shortButtonWidth);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CmsThemeColors colors,  CmsThemeTextStyles textStyles,  BorderRadius borderRadius,  EdgeInsets fieldContentPadding,  double pageTopPadding,  List<BoxShadow> menuShadow,  BorderRadius menuRadius,  double shortButtonWidth)?  $default,) {final _that = this;
switch (_that) {
case _CmsThemeData() when $default != null:
return $default(_that.colors,_that.textStyles,_that.borderRadius,_that.fieldContentPadding,_that.pageTopPadding,_that.menuShadow,_that.menuRadius,_that.shortButtonWidth);case _:
  return null;

}
}

}

/// @nodoc


class _CmsThemeData extends CmsThemeData {
  const _CmsThemeData({required this.colors, required this.textStyles, required this.borderRadius, required this.fieldContentPadding, required this.pageTopPadding, required final  List<BoxShadow> menuShadow, required this.menuRadius, required this.shortButtonWidth}): _menuShadow = menuShadow,super._();
  

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

/// Create a copy of CmsThemeData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CmsThemeDataCopyWith<_CmsThemeData> get copyWith => __$CmsThemeDataCopyWithImpl<_CmsThemeData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CmsThemeData&&(identical(other.colors, colors) || other.colors == colors)&&(identical(other.textStyles, textStyles) || other.textStyles == textStyles)&&(identical(other.borderRadius, borderRadius) || other.borderRadius == borderRadius)&&(identical(other.fieldContentPadding, fieldContentPadding) || other.fieldContentPadding == fieldContentPadding)&&(identical(other.pageTopPadding, pageTopPadding) || other.pageTopPadding == pageTopPadding)&&const DeepCollectionEquality().equals(other._menuShadow, _menuShadow)&&(identical(other.menuRadius, menuRadius) || other.menuRadius == menuRadius)&&(identical(other.shortButtonWidth, shortButtonWidth) || other.shortButtonWidth == shortButtonWidth));
}


@override
int get hashCode => Object.hash(runtimeType,colors,textStyles,borderRadius,fieldContentPadding,pageTopPadding,const DeepCollectionEquality().hash(_menuShadow),menuRadius,shortButtonWidth);

@override
String toString() {
  return 'CmsThemeData(colors: $colors, textStyles: $textStyles, borderRadius: $borderRadius, fieldContentPadding: $fieldContentPadding, pageTopPadding: $pageTopPadding, menuShadow: $menuShadow, menuRadius: $menuRadius, shortButtonWidth: $shortButtonWidth)';
}


}

/// @nodoc
abstract mixin class _$CmsThemeDataCopyWith<$Res> implements $CmsThemeDataCopyWith<$Res> {
  factory _$CmsThemeDataCopyWith(_CmsThemeData value, $Res Function(_CmsThemeData) _then) = __$CmsThemeDataCopyWithImpl;
@override @useResult
$Res call({
 CmsThemeColors colors, CmsThemeTextStyles textStyles, BorderRadius borderRadius, EdgeInsets fieldContentPadding, double pageTopPadding, List<BoxShadow> menuShadow, BorderRadius menuRadius, double shortButtonWidth
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
@override @pragma('vm:prefer-inline') $Res call({Object? colors = null,Object? textStyles = null,Object? borderRadius = null,Object? fieldContentPadding = null,Object? pageTopPadding = null,Object? menuShadow = null,Object? menuRadius = null,Object? shortButtonWidth = null,}) {
  return _then(_CmsThemeData(
colors: null == colors ? _self.colors : colors // ignore: cast_nullable_to_non_nullable
as CmsThemeColors,textStyles: null == textStyles ? _self.textStyles : textStyles // ignore: cast_nullable_to_non_nullable
as CmsThemeTextStyles,borderRadius: null == borderRadius ? _self.borderRadius : borderRadius // ignore: cast_nullable_to_non_nullable
as BorderRadius,fieldContentPadding: null == fieldContentPadding ? _self.fieldContentPadding : fieldContentPadding // ignore: cast_nullable_to_non_nullable
as EdgeInsets,pageTopPadding: null == pageTopPadding ? _self.pageTopPadding : pageTopPadding // ignore: cast_nullable_to_non_nullable
as double,menuShadow: null == menuShadow ? _self._menuShadow : menuShadow // ignore: cast_nullable_to_non_nullable
as List<BoxShadow>,menuRadius: null == menuRadius ? _self.menuRadius : menuRadius // ignore: cast_nullable_to_non_nullable
as BorderRadius,shortButtonWidth: null == shortButtonWidth ? _self.shortButtonWidth : shortButtonWidth // ignore: cast_nullable_to_non_nullable
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
