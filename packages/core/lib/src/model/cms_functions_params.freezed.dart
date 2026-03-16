// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cms_functions_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CmsFunctionsSortingParams {

 bool get sortDesc; bool get invertNulls; String get fieldKey;
/// Create a copy of CmsFunctionsSortingParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CmsFunctionsSortingParamsCopyWith<CmsFunctionsSortingParams> get copyWith => _$CmsFunctionsSortingParamsCopyWithImpl<CmsFunctionsSortingParams>(this as CmsFunctionsSortingParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CmsFunctionsSortingParams&&(identical(other.sortDesc, sortDesc) || other.sortDesc == sortDesc)&&(identical(other.invertNulls, invertNulls) || other.invertNulls == invertNulls)&&(identical(other.fieldKey, fieldKey) || other.fieldKey == fieldKey));
}


@override
int get hashCode => Object.hash(runtimeType,sortDesc,invertNulls,fieldKey);

@override
String toString() {
  return 'CmsFunctionsSortingParams(sortDesc: $sortDesc, invertNulls: $invertNulls, fieldKey: $fieldKey)';
}


}

/// @nodoc
abstract mixin class $CmsFunctionsSortingParamsCopyWith<$Res>  {
  factory $CmsFunctionsSortingParamsCopyWith(CmsFunctionsSortingParams value, $Res Function(CmsFunctionsSortingParams) _then) = _$CmsFunctionsSortingParamsCopyWithImpl;
@useResult
$Res call({
 bool sortDesc, bool invertNulls, String fieldKey
});




}
/// @nodoc
class _$CmsFunctionsSortingParamsCopyWithImpl<$Res>
    implements $CmsFunctionsSortingParamsCopyWith<$Res> {
  _$CmsFunctionsSortingParamsCopyWithImpl(this._self, this._then);

  final CmsFunctionsSortingParams _self;
  final $Res Function(CmsFunctionsSortingParams) _then;

/// Create a copy of CmsFunctionsSortingParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sortDesc = null,Object? invertNulls = null,Object? fieldKey = null,}) {
  return _then(_self.copyWith(
sortDesc: null == sortDesc ? _self.sortDesc : sortDesc // ignore: cast_nullable_to_non_nullable
as bool,invertNulls: null == invertNulls ? _self.invertNulls : invertNulls // ignore: cast_nullable_to_non_nullable
as bool,fieldKey: null == fieldKey ? _self.fieldKey : fieldKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CmsFunctionsSortingParams].
extension CmsFunctionsSortingParamsPatterns on CmsFunctionsSortingParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CmsFunctionsSortingParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CmsFunctionsSortingParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CmsFunctionsSortingParams value)  $default,){
final _that = this;
switch (_that) {
case _CmsFunctionsSortingParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CmsFunctionsSortingParams value)?  $default,){
final _that = this;
switch (_that) {
case _CmsFunctionsSortingParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool sortDesc,  bool invertNulls,  String fieldKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CmsFunctionsSortingParams() when $default != null:
return $default(_that.sortDesc,_that.invertNulls,_that.fieldKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool sortDesc,  bool invertNulls,  String fieldKey)  $default,) {final _that = this;
switch (_that) {
case _CmsFunctionsSortingParams():
return $default(_that.sortDesc,_that.invertNulls,_that.fieldKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool sortDesc,  bool invertNulls,  String fieldKey)?  $default,) {final _that = this;
switch (_that) {
case _CmsFunctionsSortingParams() when $default != null:
return $default(_that.sortDesc,_that.invertNulls,_that.fieldKey);case _:
  return null;

}
}

}

/// @nodoc


class _CmsFunctionsSortingParams implements CmsFunctionsSortingParams {
  const _CmsFunctionsSortingParams({required this.sortDesc, this.invertNulls = false, required this.fieldKey});
  

@override final  bool sortDesc;
@override@JsonKey() final  bool invertNulls;
@override final  String fieldKey;

/// Create a copy of CmsFunctionsSortingParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CmsFunctionsSortingParamsCopyWith<_CmsFunctionsSortingParams> get copyWith => __$CmsFunctionsSortingParamsCopyWithImpl<_CmsFunctionsSortingParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CmsFunctionsSortingParams&&(identical(other.sortDesc, sortDesc) || other.sortDesc == sortDesc)&&(identical(other.invertNulls, invertNulls) || other.invertNulls == invertNulls)&&(identical(other.fieldKey, fieldKey) || other.fieldKey == fieldKey));
}


@override
int get hashCode => Object.hash(runtimeType,sortDesc,invertNulls,fieldKey);

@override
String toString() {
  return 'CmsFunctionsSortingParams(sortDesc: $sortDesc, invertNulls: $invertNulls, fieldKey: $fieldKey)';
}


}

/// @nodoc
abstract mixin class _$CmsFunctionsSortingParamsCopyWith<$Res> implements $CmsFunctionsSortingParamsCopyWith<$Res> {
  factory _$CmsFunctionsSortingParamsCopyWith(_CmsFunctionsSortingParams value, $Res Function(_CmsFunctionsSortingParams) _then) = __$CmsFunctionsSortingParamsCopyWithImpl;
@override @useResult
$Res call({
 bool sortDesc, bool invertNulls, String fieldKey
});




}
/// @nodoc
class __$CmsFunctionsSortingParamsCopyWithImpl<$Res>
    implements _$CmsFunctionsSortingParamsCopyWith<$Res> {
  __$CmsFunctionsSortingParamsCopyWithImpl(this._self, this._then);

  final _CmsFunctionsSortingParams _self;
  final $Res Function(_CmsFunctionsSortingParams) _then;

/// Create a copy of CmsFunctionsSortingParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sortDesc = null,Object? invertNulls = null,Object? fieldKey = null,}) {
  return _then(_CmsFunctionsSortingParams(
sortDesc: null == sortDesc ? _self.sortDesc : sortDesc // ignore: cast_nullable_to_non_nullable
as bool,invertNulls: null == invertNulls ? _self.invertNulls : invertNulls // ignore: cast_nullable_to_non_nullable
as bool,fieldKey: null == fieldKey ? _self.fieldKey : fieldKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
