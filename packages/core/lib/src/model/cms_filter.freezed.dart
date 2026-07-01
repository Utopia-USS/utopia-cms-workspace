// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cms_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CmsFilter {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CmsFilter);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CmsFilter()';
}


}

/// @nodoc
class $CmsFilterCopyWith<$Res>  {
$CmsFilterCopyWith(CmsFilter _, $Res Function(CmsFilter) __);
}


/// Adds pattern-matching-related methods to [CmsFilter].
extension CmsFilterPatterns on CmsFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CmsFilterAll value)?  all,TResult Function( CmsFilterEquals value)?  equals,TResult Function( CmsFilterNotEquals value)?  notEquals,TResult Function( CmsFilterContains value)?  containsString,TResult Function( CmsFilterInList value)?  inList,TResult Function( CmsFilterAnd value)?  and,TResult Function( CmsFilterOr value)?  or,TResult Function( CmsFilterGreaterOrEq value)?  greaterOrEq,TResult Function( CmsFilterLesserOrEq value)?  lesserOrEq,TResult Function( CmsFilterNot value)?  not,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CmsFilterAll() when all != null:
return all(_that);case CmsFilterEquals() when equals != null:
return equals(_that);case CmsFilterNotEquals() when notEquals != null:
return notEquals(_that);case CmsFilterContains() when containsString != null:
return containsString(_that);case CmsFilterInList() when inList != null:
return inList(_that);case CmsFilterAnd() when and != null:
return and(_that);case CmsFilterOr() when or != null:
return or(_that);case CmsFilterGreaterOrEq() when greaterOrEq != null:
return greaterOrEq(_that);case CmsFilterLesserOrEq() when lesserOrEq != null:
return lesserOrEq(_that);case CmsFilterNot() when not != null:
return not(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CmsFilterAll value)  all,required TResult Function( CmsFilterEquals value)  equals,required TResult Function( CmsFilterNotEquals value)  notEquals,required TResult Function( CmsFilterContains value)  containsString,required TResult Function( CmsFilterInList value)  inList,required TResult Function( CmsFilterAnd value)  and,required TResult Function( CmsFilterOr value)  or,required TResult Function( CmsFilterGreaterOrEq value)  greaterOrEq,required TResult Function( CmsFilterLesserOrEq value)  lesserOrEq,required TResult Function( CmsFilterNot value)  not,}){
final _that = this;
switch (_that) {
case CmsFilterAll():
return all(_that);case CmsFilterEquals():
return equals(_that);case CmsFilterNotEquals():
return notEquals(_that);case CmsFilterContains():
return containsString(_that);case CmsFilterInList():
return inList(_that);case CmsFilterAnd():
return and(_that);case CmsFilterOr():
return or(_that);case CmsFilterGreaterOrEq():
return greaterOrEq(_that);case CmsFilterLesserOrEq():
return lesserOrEq(_that);case CmsFilterNot():
return not(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CmsFilterAll value)?  all,TResult? Function( CmsFilterEquals value)?  equals,TResult? Function( CmsFilterNotEquals value)?  notEquals,TResult? Function( CmsFilterContains value)?  containsString,TResult? Function( CmsFilterInList value)?  inList,TResult? Function( CmsFilterAnd value)?  and,TResult? Function( CmsFilterOr value)?  or,TResult? Function( CmsFilterGreaterOrEq value)?  greaterOrEq,TResult? Function( CmsFilterLesserOrEq value)?  lesserOrEq,TResult? Function( CmsFilterNot value)?  not,}){
final _that = this;
switch (_that) {
case CmsFilterAll() when all != null:
return all(_that);case CmsFilterEquals() when equals != null:
return equals(_that);case CmsFilterNotEquals() when notEquals != null:
return notEquals(_that);case CmsFilterContains() when containsString != null:
return containsString(_that);case CmsFilterInList() when inList != null:
return inList(_that);case CmsFilterAnd() when and != null:
return and(_that);case CmsFilterOr() when or != null:
return or(_that);case CmsFilterGreaterOrEq() when greaterOrEq != null:
return greaterOrEq(_that);case CmsFilterLesserOrEq() when lesserOrEq != null:
return lesserOrEq(_that);case CmsFilterNot() when not != null:
return not(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  all,TResult Function( String field,  Object? value)?  equals,TResult Function( String field,  Object? value)?  notEquals,TResult Function( String field,  String value,  bool caseSensitive)?  containsString,TResult Function( String field,  List<Object> values)?  inList,TResult Function( List<CmsFilter> filters)?  and,TResult Function( List<CmsFilter> filters)?  or,TResult Function( String field,  Object value)?  greaterOrEq,TResult Function( String field,  Object value)?  lesserOrEq,TResult Function( CmsFilter filter)?  not,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CmsFilterAll() when all != null:
return all();case CmsFilterEquals() when equals != null:
return equals(_that.field,_that.value);case CmsFilterNotEquals() when notEquals != null:
return notEquals(_that.field,_that.value);case CmsFilterContains() when containsString != null:
return containsString(_that.field,_that.value,_that.caseSensitive);case CmsFilterInList() when inList != null:
return inList(_that.field,_that.values);case CmsFilterAnd() when and != null:
return and(_that.filters);case CmsFilterOr() when or != null:
return or(_that.filters);case CmsFilterGreaterOrEq() when greaterOrEq != null:
return greaterOrEq(_that.field,_that.value);case CmsFilterLesserOrEq() when lesserOrEq != null:
return lesserOrEq(_that.field,_that.value);case CmsFilterNot() when not != null:
return not(_that.filter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  all,required TResult Function( String field,  Object? value)  equals,required TResult Function( String field,  Object? value)  notEquals,required TResult Function( String field,  String value,  bool caseSensitive)  containsString,required TResult Function( String field,  List<Object> values)  inList,required TResult Function( List<CmsFilter> filters)  and,required TResult Function( List<CmsFilter> filters)  or,required TResult Function( String field,  Object value)  greaterOrEq,required TResult Function( String field,  Object value)  lesserOrEq,required TResult Function( CmsFilter filter)  not,}) {final _that = this;
switch (_that) {
case CmsFilterAll():
return all();case CmsFilterEquals():
return equals(_that.field,_that.value);case CmsFilterNotEquals():
return notEquals(_that.field,_that.value);case CmsFilterContains():
return containsString(_that.field,_that.value,_that.caseSensitive);case CmsFilterInList():
return inList(_that.field,_that.values);case CmsFilterAnd():
return and(_that.filters);case CmsFilterOr():
return or(_that.filters);case CmsFilterGreaterOrEq():
return greaterOrEq(_that.field,_that.value);case CmsFilterLesserOrEq():
return lesserOrEq(_that.field,_that.value);case CmsFilterNot():
return not(_that.filter);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  all,TResult? Function( String field,  Object? value)?  equals,TResult? Function( String field,  Object? value)?  notEquals,TResult? Function( String field,  String value,  bool caseSensitive)?  containsString,TResult? Function( String field,  List<Object> values)?  inList,TResult? Function( List<CmsFilter> filters)?  and,TResult? Function( List<CmsFilter> filters)?  or,TResult? Function( String field,  Object value)?  greaterOrEq,TResult? Function( String field,  Object value)?  lesserOrEq,TResult? Function( CmsFilter filter)?  not,}) {final _that = this;
switch (_that) {
case CmsFilterAll() when all != null:
return all();case CmsFilterEquals() when equals != null:
return equals(_that.field,_that.value);case CmsFilterNotEquals() when notEquals != null:
return notEquals(_that.field,_that.value);case CmsFilterContains() when containsString != null:
return containsString(_that.field,_that.value,_that.caseSensitive);case CmsFilterInList() when inList != null:
return inList(_that.field,_that.values);case CmsFilterAnd() when and != null:
return and(_that.filters);case CmsFilterOr() when or != null:
return or(_that.filters);case CmsFilterGreaterOrEq() when greaterOrEq != null:
return greaterOrEq(_that.field,_that.value);case CmsFilterLesserOrEq() when lesserOrEq != null:
return lesserOrEq(_that.field,_that.value);case CmsFilterNot() when not != null:
return not(_that.filter);case _:
  return null;

}
}

}

/// @nodoc


class CmsFilterAll implements CmsFilter {
  const CmsFilterAll();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CmsFilterAll);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CmsFilter.all()';
}


}




/// @nodoc


class CmsFilterEquals implements CmsFilter {
  const CmsFilterEquals(this.field, this.value);
  

 final  String field;
 final  Object? value;

/// Create a copy of CmsFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CmsFilterEqualsCopyWith<CmsFilterEquals> get copyWith => _$CmsFilterEqualsCopyWithImpl<CmsFilterEquals>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CmsFilterEquals&&(identical(other.field, field) || other.field == field)&&const DeepCollectionEquality().equals(other.value, value));
}


@override
int get hashCode => Object.hash(runtimeType,field,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'CmsFilter.equals(field: $field, value: $value)';
}


}

/// @nodoc
abstract mixin class $CmsFilterEqualsCopyWith<$Res> implements $CmsFilterCopyWith<$Res> {
  factory $CmsFilterEqualsCopyWith(CmsFilterEquals value, $Res Function(CmsFilterEquals) _then) = _$CmsFilterEqualsCopyWithImpl;
@useResult
$Res call({
 String field, Object? value
});




}
/// @nodoc
class _$CmsFilterEqualsCopyWithImpl<$Res>
    implements $CmsFilterEqualsCopyWith<$Res> {
  _$CmsFilterEqualsCopyWithImpl(this._self, this._then);

  final CmsFilterEquals _self;
  final $Res Function(CmsFilterEquals) _then;

/// Create a copy of CmsFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field = null,Object? value = freezed,}) {
  return _then(CmsFilterEquals(
null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,freezed == value ? _self.value : value ,
  ));
}


}

/// @nodoc


class CmsFilterNotEquals implements CmsFilter {
  const CmsFilterNotEquals(this.field, this.value);
  

 final  String field;
 final  Object? value;

/// Create a copy of CmsFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CmsFilterNotEqualsCopyWith<CmsFilterNotEquals> get copyWith => _$CmsFilterNotEqualsCopyWithImpl<CmsFilterNotEquals>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CmsFilterNotEquals&&(identical(other.field, field) || other.field == field)&&const DeepCollectionEquality().equals(other.value, value));
}


@override
int get hashCode => Object.hash(runtimeType,field,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'CmsFilter.notEquals(field: $field, value: $value)';
}


}

/// @nodoc
abstract mixin class $CmsFilterNotEqualsCopyWith<$Res> implements $CmsFilterCopyWith<$Res> {
  factory $CmsFilterNotEqualsCopyWith(CmsFilterNotEquals value, $Res Function(CmsFilterNotEquals) _then) = _$CmsFilterNotEqualsCopyWithImpl;
@useResult
$Res call({
 String field, Object? value
});




}
/// @nodoc
class _$CmsFilterNotEqualsCopyWithImpl<$Res>
    implements $CmsFilterNotEqualsCopyWith<$Res> {
  _$CmsFilterNotEqualsCopyWithImpl(this._self, this._then);

  final CmsFilterNotEquals _self;
  final $Res Function(CmsFilterNotEquals) _then;

/// Create a copy of CmsFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field = null,Object? value = freezed,}) {
  return _then(CmsFilterNotEquals(
null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,freezed == value ? _self.value : value ,
  ));
}


}

/// @nodoc


class CmsFilterContains implements CmsFilter {
  const CmsFilterContains(this.field, this.value, {this.caseSensitive = false});
  

 final  String field;
 final  String value;
@JsonKey() final  bool caseSensitive;

/// Create a copy of CmsFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CmsFilterContainsCopyWith<CmsFilterContains> get copyWith => _$CmsFilterContainsCopyWithImpl<CmsFilterContains>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CmsFilterContains&&(identical(other.field, field) || other.field == field)&&(identical(other.value, value) || other.value == value)&&(identical(other.caseSensitive, caseSensitive) || other.caseSensitive == caseSensitive));
}


@override
int get hashCode => Object.hash(runtimeType,field,value,caseSensitive);

@override
String toString() {
  return 'CmsFilter.containsString(field: $field, value: $value, caseSensitive: $caseSensitive)';
}


}

/// @nodoc
abstract mixin class $CmsFilterContainsCopyWith<$Res> implements $CmsFilterCopyWith<$Res> {
  factory $CmsFilterContainsCopyWith(CmsFilterContains value, $Res Function(CmsFilterContains) _then) = _$CmsFilterContainsCopyWithImpl;
@useResult
$Res call({
 String field, String value, bool caseSensitive
});




}
/// @nodoc
class _$CmsFilterContainsCopyWithImpl<$Res>
    implements $CmsFilterContainsCopyWith<$Res> {
  _$CmsFilterContainsCopyWithImpl(this._self, this._then);

  final CmsFilterContains _self;
  final $Res Function(CmsFilterContains) _then;

/// Create a copy of CmsFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field = null,Object? value = null,Object? caseSensitive = null,}) {
  return _then(CmsFilterContains(
null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,caseSensitive: null == caseSensitive ? _self.caseSensitive : caseSensitive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class CmsFilterInList implements CmsFilter {
  const CmsFilterInList(this.field, final  List<Object> values): _values = values;
  

 final  String field;
 final  List<Object> _values;
 List<Object> get values {
  if (_values is EqualUnmodifiableListView) return _values;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_values);
}


/// Create a copy of CmsFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CmsFilterInListCopyWith<CmsFilterInList> get copyWith => _$CmsFilterInListCopyWithImpl<CmsFilterInList>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CmsFilterInList&&(identical(other.field, field) || other.field == field)&&const DeepCollectionEquality().equals(other._values, _values));
}


@override
int get hashCode => Object.hash(runtimeType,field,const DeepCollectionEquality().hash(_values));

@override
String toString() {
  return 'CmsFilter.inList(field: $field, values: $values)';
}


}

/// @nodoc
abstract mixin class $CmsFilterInListCopyWith<$Res> implements $CmsFilterCopyWith<$Res> {
  factory $CmsFilterInListCopyWith(CmsFilterInList value, $Res Function(CmsFilterInList) _then) = _$CmsFilterInListCopyWithImpl;
@useResult
$Res call({
 String field, List<Object> values
});




}
/// @nodoc
class _$CmsFilterInListCopyWithImpl<$Res>
    implements $CmsFilterInListCopyWith<$Res> {
  _$CmsFilterInListCopyWithImpl(this._self, this._then);

  final CmsFilterInList _self;
  final $Res Function(CmsFilterInList) _then;

/// Create a copy of CmsFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field = null,Object? values = null,}) {
  return _then(CmsFilterInList(
null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,null == values ? _self._values : values // ignore: cast_nullable_to_non_nullable
as List<Object>,
  ));
}


}

/// @nodoc


class CmsFilterAnd implements CmsFilter {
  const CmsFilterAnd(final  List<CmsFilter> filters): _filters = filters;
  

 final  List<CmsFilter> _filters;
 List<CmsFilter> get filters {
  if (_filters is EqualUnmodifiableListView) return _filters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filters);
}


/// Create a copy of CmsFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CmsFilterAndCopyWith<CmsFilterAnd> get copyWith => _$CmsFilterAndCopyWithImpl<CmsFilterAnd>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CmsFilterAnd&&const DeepCollectionEquality().equals(other._filters, _filters));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_filters));

@override
String toString() {
  return 'CmsFilter.and(filters: $filters)';
}


}

/// @nodoc
abstract mixin class $CmsFilterAndCopyWith<$Res> implements $CmsFilterCopyWith<$Res> {
  factory $CmsFilterAndCopyWith(CmsFilterAnd value, $Res Function(CmsFilterAnd) _then) = _$CmsFilterAndCopyWithImpl;
@useResult
$Res call({
 List<CmsFilter> filters
});




}
/// @nodoc
class _$CmsFilterAndCopyWithImpl<$Res>
    implements $CmsFilterAndCopyWith<$Res> {
  _$CmsFilterAndCopyWithImpl(this._self, this._then);

  final CmsFilterAnd _self;
  final $Res Function(CmsFilterAnd) _then;

/// Create a copy of CmsFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filters = null,}) {
  return _then(CmsFilterAnd(
null == filters ? _self._filters : filters // ignore: cast_nullable_to_non_nullable
as List<CmsFilter>,
  ));
}


}

/// @nodoc


class CmsFilterOr implements CmsFilter {
  const CmsFilterOr(final  List<CmsFilter> filters): _filters = filters;
  

 final  List<CmsFilter> _filters;
 List<CmsFilter> get filters {
  if (_filters is EqualUnmodifiableListView) return _filters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filters);
}


/// Create a copy of CmsFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CmsFilterOrCopyWith<CmsFilterOr> get copyWith => _$CmsFilterOrCopyWithImpl<CmsFilterOr>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CmsFilterOr&&const DeepCollectionEquality().equals(other._filters, _filters));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_filters));

@override
String toString() {
  return 'CmsFilter.or(filters: $filters)';
}


}

/// @nodoc
abstract mixin class $CmsFilterOrCopyWith<$Res> implements $CmsFilterCopyWith<$Res> {
  factory $CmsFilterOrCopyWith(CmsFilterOr value, $Res Function(CmsFilterOr) _then) = _$CmsFilterOrCopyWithImpl;
@useResult
$Res call({
 List<CmsFilter> filters
});




}
/// @nodoc
class _$CmsFilterOrCopyWithImpl<$Res>
    implements $CmsFilterOrCopyWith<$Res> {
  _$CmsFilterOrCopyWithImpl(this._self, this._then);

  final CmsFilterOr _self;
  final $Res Function(CmsFilterOr) _then;

/// Create a copy of CmsFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filters = null,}) {
  return _then(CmsFilterOr(
null == filters ? _self._filters : filters // ignore: cast_nullable_to_non_nullable
as List<CmsFilter>,
  ));
}


}

/// @nodoc


class CmsFilterGreaterOrEq implements CmsFilter {
  const CmsFilterGreaterOrEq(this.field, this.value);
  

 final  String field;
 final  Object value;

/// Create a copy of CmsFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CmsFilterGreaterOrEqCopyWith<CmsFilterGreaterOrEq> get copyWith => _$CmsFilterGreaterOrEqCopyWithImpl<CmsFilterGreaterOrEq>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CmsFilterGreaterOrEq&&(identical(other.field, field) || other.field == field)&&const DeepCollectionEquality().equals(other.value, value));
}


@override
int get hashCode => Object.hash(runtimeType,field,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'CmsFilter.greaterOrEq(field: $field, value: $value)';
}


}

/// @nodoc
abstract mixin class $CmsFilterGreaterOrEqCopyWith<$Res> implements $CmsFilterCopyWith<$Res> {
  factory $CmsFilterGreaterOrEqCopyWith(CmsFilterGreaterOrEq value, $Res Function(CmsFilterGreaterOrEq) _then) = _$CmsFilterGreaterOrEqCopyWithImpl;
@useResult
$Res call({
 String field, Object value
});




}
/// @nodoc
class _$CmsFilterGreaterOrEqCopyWithImpl<$Res>
    implements $CmsFilterGreaterOrEqCopyWith<$Res> {
  _$CmsFilterGreaterOrEqCopyWithImpl(this._self, this._then);

  final CmsFilterGreaterOrEq _self;
  final $Res Function(CmsFilterGreaterOrEq) _then;

/// Create a copy of CmsFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field = null,Object? value = null,}) {
  return _then(CmsFilterGreaterOrEq(
null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,null == value ? _self.value : value ,
  ));
}


}

/// @nodoc


class CmsFilterLesserOrEq implements CmsFilter {
  const CmsFilterLesserOrEq(this.field, this.value);
  

 final  String field;
 final  Object value;

/// Create a copy of CmsFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CmsFilterLesserOrEqCopyWith<CmsFilterLesserOrEq> get copyWith => _$CmsFilterLesserOrEqCopyWithImpl<CmsFilterLesserOrEq>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CmsFilterLesserOrEq&&(identical(other.field, field) || other.field == field)&&const DeepCollectionEquality().equals(other.value, value));
}


@override
int get hashCode => Object.hash(runtimeType,field,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'CmsFilter.lesserOrEq(field: $field, value: $value)';
}


}

/// @nodoc
abstract mixin class $CmsFilterLesserOrEqCopyWith<$Res> implements $CmsFilterCopyWith<$Res> {
  factory $CmsFilterLesserOrEqCopyWith(CmsFilterLesserOrEq value, $Res Function(CmsFilterLesserOrEq) _then) = _$CmsFilterLesserOrEqCopyWithImpl;
@useResult
$Res call({
 String field, Object value
});




}
/// @nodoc
class _$CmsFilterLesserOrEqCopyWithImpl<$Res>
    implements $CmsFilterLesserOrEqCopyWith<$Res> {
  _$CmsFilterLesserOrEqCopyWithImpl(this._self, this._then);

  final CmsFilterLesserOrEq _self;
  final $Res Function(CmsFilterLesserOrEq) _then;

/// Create a copy of CmsFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field = null,Object? value = null,}) {
  return _then(CmsFilterLesserOrEq(
null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,null == value ? _self.value : value ,
  ));
}


}

/// @nodoc


class CmsFilterNot implements CmsFilter {
  const CmsFilterNot(this.filter);
  

 final  CmsFilter filter;

/// Create a copy of CmsFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CmsFilterNotCopyWith<CmsFilterNot> get copyWith => _$CmsFilterNotCopyWithImpl<CmsFilterNot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CmsFilterNot&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,filter);

@override
String toString() {
  return 'CmsFilter.not(filter: $filter)';
}


}

/// @nodoc
abstract mixin class $CmsFilterNotCopyWith<$Res> implements $CmsFilterCopyWith<$Res> {
  factory $CmsFilterNotCopyWith(CmsFilterNot value, $Res Function(CmsFilterNot) _then) = _$CmsFilterNotCopyWithImpl;
@useResult
$Res call({
 CmsFilter filter
});


$CmsFilterCopyWith<$Res> get filter;

}
/// @nodoc
class _$CmsFilterNotCopyWithImpl<$Res>
    implements $CmsFilterNotCopyWith<$Res> {
  _$CmsFilterNotCopyWithImpl(this._self, this._then);

  final CmsFilterNot _self;
  final $Res Function(CmsFilterNot) _then;

/// Create a copy of CmsFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filter = null,}) {
  return _then(CmsFilterNot(
null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as CmsFilter,
  ));
}

/// Create a copy of CmsFilter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CmsFilterCopyWith<$Res> get filter {
  
  return $CmsFilterCopyWith<$Res>(_self.filter, (value) {
    return _then(_self.copyWith(filter: value));
  });
}
}

// dart format on
