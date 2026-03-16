// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cms_theme_colors.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CmsThemeColors {

 Color get primary; Color get accent; Color get field; Color get canvas; Color get error; Color get disabled; Color get text;
/// Create a copy of CmsThemeColors
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CmsThemeColorsCopyWith<CmsThemeColors> get copyWith => _$CmsThemeColorsCopyWithImpl<CmsThemeColors>(this as CmsThemeColors, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CmsThemeColors&&(identical(other.primary, primary) || other.primary == primary)&&(identical(other.accent, accent) || other.accent == accent)&&(identical(other.field, field) || other.field == field)&&(identical(other.canvas, canvas) || other.canvas == canvas)&&(identical(other.error, error) || other.error == error)&&(identical(other.disabled, disabled) || other.disabled == disabled)&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,primary,accent,field,canvas,error,disabled,text);

@override
String toString() {
  return 'CmsThemeColors(primary: $primary, accent: $accent, field: $field, canvas: $canvas, error: $error, disabled: $disabled, text: $text)';
}


}

/// @nodoc
abstract mixin class $CmsThemeColorsCopyWith<$Res>  {
  factory $CmsThemeColorsCopyWith(CmsThemeColors value, $Res Function(CmsThemeColors) _then) = _$CmsThemeColorsCopyWithImpl;
@useResult
$Res call({
 Color primary, Color accent, Color field, Color canvas, Color error, Color disabled, Color text
});




}
/// @nodoc
class _$CmsThemeColorsCopyWithImpl<$Res>
    implements $CmsThemeColorsCopyWith<$Res> {
  _$CmsThemeColorsCopyWithImpl(this._self, this._then);

  final CmsThemeColors _self;
  final $Res Function(CmsThemeColors) _then;

/// Create a copy of CmsThemeColors
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? primary = null,Object? accent = null,Object? field = null,Object? canvas = null,Object? error = null,Object? disabled = null,Object? text = null,}) {
  return _then(_self.copyWith(
primary: null == primary ? _self.primary : primary // ignore: cast_nullable_to_non_nullable
as Color,accent: null == accent ? _self.accent : accent // ignore: cast_nullable_to_non_nullable
as Color,field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as Color,canvas: null == canvas ? _self.canvas : canvas // ignore: cast_nullable_to_non_nullable
as Color,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as Color,disabled: null == disabled ? _self.disabled : disabled // ignore: cast_nullable_to_non_nullable
as Color,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}

}


/// Adds pattern-matching-related methods to [CmsThemeColors].
extension CmsThemeColorsPatterns on CmsThemeColors {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CmsThemeColors value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CmsThemeColors() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CmsThemeColors value)  $default,){
final _that = this;
switch (_that) {
case _CmsThemeColors():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CmsThemeColors value)?  $default,){
final _that = this;
switch (_that) {
case _CmsThemeColors() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Color primary,  Color accent,  Color field,  Color canvas,  Color error,  Color disabled,  Color text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CmsThemeColors() when $default != null:
return $default(_that.primary,_that.accent,_that.field,_that.canvas,_that.error,_that.disabled,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Color primary,  Color accent,  Color field,  Color canvas,  Color error,  Color disabled,  Color text)  $default,) {final _that = this;
switch (_that) {
case _CmsThemeColors():
return $default(_that.primary,_that.accent,_that.field,_that.canvas,_that.error,_that.disabled,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Color primary,  Color accent,  Color field,  Color canvas,  Color error,  Color disabled,  Color text)?  $default,) {final _that = this;
switch (_that) {
case _CmsThemeColors() when $default != null:
return $default(_that.primary,_that.accent,_that.field,_that.canvas,_that.error,_that.disabled,_that.text);case _:
  return null;

}
}

}

/// @nodoc


class _CmsThemeColors extends CmsThemeColors {
   _CmsThemeColors({required this.primary, required this.accent, required this.field, required this.canvas, required this.error, required this.disabled, required this.text}): super._();
  

@override final  Color primary;
@override final  Color accent;
@override final  Color field;
@override final  Color canvas;
@override final  Color error;
@override final  Color disabled;
@override final  Color text;

/// Create a copy of CmsThemeColors
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CmsThemeColorsCopyWith<_CmsThemeColors> get copyWith => __$CmsThemeColorsCopyWithImpl<_CmsThemeColors>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CmsThemeColors&&(identical(other.primary, primary) || other.primary == primary)&&(identical(other.accent, accent) || other.accent == accent)&&(identical(other.field, field) || other.field == field)&&(identical(other.canvas, canvas) || other.canvas == canvas)&&(identical(other.error, error) || other.error == error)&&(identical(other.disabled, disabled) || other.disabled == disabled)&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,primary,accent,field,canvas,error,disabled,text);

@override
String toString() {
  return 'CmsThemeColors(primary: $primary, accent: $accent, field: $field, canvas: $canvas, error: $error, disabled: $disabled, text: $text)';
}


}

/// @nodoc
abstract mixin class _$CmsThemeColorsCopyWith<$Res> implements $CmsThemeColorsCopyWith<$Res> {
  factory _$CmsThemeColorsCopyWith(_CmsThemeColors value, $Res Function(_CmsThemeColors) _then) = __$CmsThemeColorsCopyWithImpl;
@override @useResult
$Res call({
 Color primary, Color accent, Color field, Color canvas, Color error, Color disabled, Color text
});




}
/// @nodoc
class __$CmsThemeColorsCopyWithImpl<$Res>
    implements _$CmsThemeColorsCopyWith<$Res> {
  __$CmsThemeColorsCopyWithImpl(this._self, this._then);

  final _CmsThemeColors _self;
  final $Res Function(_CmsThemeColors) _then;

/// Create a copy of CmsThemeColors
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? primary = null,Object? accent = null,Object? field = null,Object? canvas = null,Object? error = null,Object? disabled = null,Object? text = null,}) {
  return _then(_CmsThemeColors(
primary: null == primary ? _self.primary : primary // ignore: cast_nullable_to_non_nullable
as Color,accent: null == accent ? _self.accent : accent // ignore: cast_nullable_to_non_nullable
as Color,field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as Color,canvas: null == canvas ? _self.canvas : canvas // ignore: cast_nullable_to_non_nullable
as Color,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as Color,disabled: null == disabled ? _self.disabled : disabled // ignore: cast_nullable_to_non_nullable
as Color,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

// dart format on
