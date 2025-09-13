// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'business.freezed.dart';
part 'business.g.dart';

@freezed
abstract class Business with _$Business {
  const factory Business({
    @JsonKey(name: 'biz_name') required String name,
    @JsonKey(name: 'bss_location') required String location,
    @JsonKey(name: 'contct_no') required String phone,
  }) = _Business;

  factory Business.fromJson(Map<String, dynamic> json) => _$BusinessFromJson(json);
}
