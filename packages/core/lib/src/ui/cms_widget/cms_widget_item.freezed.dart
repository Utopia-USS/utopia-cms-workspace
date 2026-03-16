// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cms_widget_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CmsWidgetItem {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CmsWidgetItem);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CmsWidgetItem()';
}


}

/// @nodoc
class $CmsWidgetItemCopyWith<$Res>  {
$CmsWidgetItemCopyWith(CmsWidgetItem _, $Res Function(CmsWidgetItem) __);
}


/// Adds pattern-matching-related methods to [CmsWidgetItem].
extension CmsWidgetItemPatterns on CmsWidgetItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CmsWidgetItemPage value)?  page,TResult Function( CmsWidgetItemAction value)?  action,TResult Function( CmsWidgetItemCustom value)?  custom,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CmsWidgetItemPage() when page != null:
return page(_that);case CmsWidgetItemAction() when action != null:
return action(_that);case CmsWidgetItemCustom() when custom != null:
return custom(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CmsWidgetItemPage value)  page,required TResult Function( CmsWidgetItemAction value)  action,required TResult Function( CmsWidgetItemCustom value)  custom,}){
final _that = this;
switch (_that) {
case CmsWidgetItemPage():
return page(_that);case CmsWidgetItemAction():
return action(_that);case CmsWidgetItemCustom():
return custom(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CmsWidgetItemPage value)?  page,TResult? Function( CmsWidgetItemAction value)?  action,TResult? Function( CmsWidgetItemCustom value)?  custom,}){
final _that = this;
switch (_that) {
case CmsWidgetItemPage() when page != null:
return page(_that);case CmsWidgetItemAction() when action != null:
return action(_that);case CmsWidgetItemCustom() when custom != null:
return custom(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Widget icon,  Widget title,  String id,  Widget content)?  page,TResult Function( Widget icon,  Widget title,  void Function() onPressed)?  action,TResult Function( int? flex,  Widget child)?  custom,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CmsWidgetItemPage() when page != null:
return page(_that.icon,_that.title,_that.id,_that.content);case CmsWidgetItemAction() when action != null:
return action(_that.icon,_that.title,_that.onPressed);case CmsWidgetItemCustom() when custom != null:
return custom(_that.flex,_that.child);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Widget icon,  Widget title,  String id,  Widget content)  page,required TResult Function( Widget icon,  Widget title,  void Function() onPressed)  action,required TResult Function( int? flex,  Widget child)  custom,}) {final _that = this;
switch (_that) {
case CmsWidgetItemPage():
return page(_that.icon,_that.title,_that.id,_that.content);case CmsWidgetItemAction():
return action(_that.icon,_that.title,_that.onPressed);case CmsWidgetItemCustom():
return custom(_that.flex,_that.child);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Widget icon,  Widget title,  String id,  Widget content)?  page,TResult? Function( Widget icon,  Widget title,  void Function() onPressed)?  action,TResult? Function( int? flex,  Widget child)?  custom,}) {final _that = this;
switch (_that) {
case CmsWidgetItemPage() when page != null:
return page(_that.icon,_that.title,_that.id,_that.content);case CmsWidgetItemAction() when action != null:
return action(_that.icon,_that.title,_that.onPressed);case CmsWidgetItemCustom() when custom != null:
return custom(_that.flex,_that.child);case _:
  return null;

}
}

}

/// @nodoc


class CmsWidgetItemPage extends CmsWidgetItem {
   CmsWidgetItemPage({required this.icon, required this.title, required this.id, required this.content}): super._();
  

 final  Widget icon;
 final  Widget title;
 final  String id;
 final  Widget content;

/// Create a copy of CmsWidgetItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CmsWidgetItemPageCopyWith<CmsWidgetItemPage> get copyWith => _$CmsWidgetItemPageCopyWithImpl<CmsWidgetItemPage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CmsWidgetItemPage&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.title, title) || other.title == title)&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content));
}


@override
int get hashCode => Object.hash(runtimeType,icon,title,id,content);

@override
String toString() {
  return 'CmsWidgetItem.page(icon: $icon, title: $title, id: $id, content: $content)';
}


}

/// @nodoc
abstract mixin class $CmsWidgetItemPageCopyWith<$Res> implements $CmsWidgetItemCopyWith<$Res> {
  factory $CmsWidgetItemPageCopyWith(CmsWidgetItemPage value, $Res Function(CmsWidgetItemPage) _then) = _$CmsWidgetItemPageCopyWithImpl;
@useResult
$Res call({
 Widget icon, Widget title, String id, Widget content
});




}
/// @nodoc
class _$CmsWidgetItemPageCopyWithImpl<$Res>
    implements $CmsWidgetItemPageCopyWith<$Res> {
  _$CmsWidgetItemPageCopyWithImpl(this._self, this._then);

  final CmsWidgetItemPage _self;
  final $Res Function(CmsWidgetItemPage) _then;

/// Create a copy of CmsWidgetItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? icon = null,Object? title = null,Object? id = null,Object? content = null,}) {
  return _then(CmsWidgetItemPage(
icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as Widget,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as Widget,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as Widget,
  ));
}


}

/// @nodoc


class CmsWidgetItemAction extends CmsWidgetItem {
   CmsWidgetItemAction({required this.icon, required this.title, required this.onPressed}): super._();
  

 final  Widget icon;
 final  Widget title;
 final  void Function() onPressed;

/// Create a copy of CmsWidgetItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CmsWidgetItemActionCopyWith<CmsWidgetItemAction> get copyWith => _$CmsWidgetItemActionCopyWithImpl<CmsWidgetItemAction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CmsWidgetItemAction&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.title, title) || other.title == title)&&(identical(other.onPressed, onPressed) || other.onPressed == onPressed));
}


@override
int get hashCode => Object.hash(runtimeType,icon,title,onPressed);

@override
String toString() {
  return 'CmsWidgetItem.action(icon: $icon, title: $title, onPressed: $onPressed)';
}


}

/// @nodoc
abstract mixin class $CmsWidgetItemActionCopyWith<$Res> implements $CmsWidgetItemCopyWith<$Res> {
  factory $CmsWidgetItemActionCopyWith(CmsWidgetItemAction value, $Res Function(CmsWidgetItemAction) _then) = _$CmsWidgetItemActionCopyWithImpl;
@useResult
$Res call({
 Widget icon, Widget title, void Function() onPressed
});




}
/// @nodoc
class _$CmsWidgetItemActionCopyWithImpl<$Res>
    implements $CmsWidgetItemActionCopyWith<$Res> {
  _$CmsWidgetItemActionCopyWithImpl(this._self, this._then);

  final CmsWidgetItemAction _self;
  final $Res Function(CmsWidgetItemAction) _then;

/// Create a copy of CmsWidgetItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? icon = null,Object? title = null,Object? onPressed = null,}) {
  return _then(CmsWidgetItemAction(
icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as Widget,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as Widget,onPressed: null == onPressed ? _self.onPressed : onPressed // ignore: cast_nullable_to_non_nullable
as void Function(),
  ));
}


}

/// @nodoc


class CmsWidgetItemCustom extends CmsWidgetItem {
   CmsWidgetItemCustom({this.flex, this.child = const SizedBox()}): super._();
  

 final  int? flex;
@JsonKey() final  Widget child;

/// Create a copy of CmsWidgetItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CmsWidgetItemCustomCopyWith<CmsWidgetItemCustom> get copyWith => _$CmsWidgetItemCustomCopyWithImpl<CmsWidgetItemCustom>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CmsWidgetItemCustom&&(identical(other.flex, flex) || other.flex == flex)&&(identical(other.child, child) || other.child == child));
}


@override
int get hashCode => Object.hash(runtimeType,flex,child);

@override
String toString() {
  return 'CmsWidgetItem.custom(flex: $flex, child: $child)';
}


}

/// @nodoc
abstract mixin class $CmsWidgetItemCustomCopyWith<$Res> implements $CmsWidgetItemCopyWith<$Res> {
  factory $CmsWidgetItemCustomCopyWith(CmsWidgetItemCustom value, $Res Function(CmsWidgetItemCustom) _then) = _$CmsWidgetItemCustomCopyWithImpl;
@useResult
$Res call({
 int? flex, Widget child
});




}
/// @nodoc
class _$CmsWidgetItemCustomCopyWithImpl<$Res>
    implements $CmsWidgetItemCustomCopyWith<$Res> {
  _$CmsWidgetItemCustomCopyWithImpl(this._self, this._then);

  final CmsWidgetItemCustom _self;
  final $Res Function(CmsWidgetItemCustom) _then;

/// Create a copy of CmsWidgetItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? flex = freezed,Object? child = null,}) {
  return _then(CmsWidgetItemCustom(
flex: freezed == flex ? _self.flex : flex // ignore: cast_nullable_to_non_nullable
as int?,child: null == child ? _self.child : child // ignore: cast_nullable_to_non_nullable
as Widget,
  ));
}


}

// dart format on
