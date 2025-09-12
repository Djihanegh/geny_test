// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Business {
  @JsonKey(name: 'biz_name')
  String get name;
  @JsonKey(name: 'bss_location')
  String get location;
  @JsonKey(name: 'contct_no')
  String get phone;

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BusinessCopyWith<Business> get copyWith =>
      _$BusinessCopyWithImpl<Business>(this as Business, _$identity);

  /// Serializes this Business to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Business &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, location, phone);

  @override
  String toString() {
    return 'Business(name: $name, location: $location, phone: $phone)';
  }
}

/// @nodoc
abstract mixin class $BusinessCopyWith<$Res> {
  factory $BusinessCopyWith(Business value, $Res Function(Business) _then) =
      _$BusinessCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'biz_name') String name,
      @JsonKey(name: 'bss_location') String location,
      @JsonKey(name: 'contct_no') String phone});
}

/// @nodoc
class _$BusinessCopyWithImpl<$Res> implements $BusinessCopyWith<$Res> {
  _$BusinessCopyWithImpl(this._self, this._then);

  final Business _self;
  final $Res Function(Business) _then;

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? location = null,
    Object? phone = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Business implements Business {
  const _Business(
      {@JsonKey(name: 'biz_name') required this.name,
      @JsonKey(name: 'bss_location') required this.location,
      @JsonKey(name: 'contct_no') required this.phone});
  factory _Business.fromJson(Map<String, dynamic> json) =>
      _$BusinessFromJson(json);

  @override
  @JsonKey(name: 'biz_name')
  final String name;
  @override
  @JsonKey(name: 'bss_location')
  final String location;
  @override
  @JsonKey(name: 'contct_no')
  final String phone;

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BusinessCopyWith<_Business> get copyWith =>
      __$BusinessCopyWithImpl<_Business>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BusinessToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Business &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, location, phone);

  @override
  String toString() {
    return 'Business(name: $name, location: $location, phone: $phone)';
  }
}

/// @nodoc
abstract mixin class _$BusinessCopyWith<$Res>
    implements $BusinessCopyWith<$Res> {
  factory _$BusinessCopyWith(_Business value, $Res Function(_Business) _then) =
      __$BusinessCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'biz_name') String name,
      @JsonKey(name: 'bss_location') String location,
      @JsonKey(name: 'contct_no') String phone});
}

/// @nodoc
class __$BusinessCopyWithImpl<$Res> implements _$BusinessCopyWith<$Res> {
  __$BusinessCopyWithImpl(this._self, this._then);

  final _Business _self;
  final $Res Function(_Business) _then;

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? location = null,
    Object? phone = null,
  }) {
    return _then(_Business(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
