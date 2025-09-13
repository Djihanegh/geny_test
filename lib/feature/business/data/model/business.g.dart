// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusinessImpl _$$BusinessImplFromJson(Map<String, dynamic> json) =>
    _$BusinessImpl(
      name: json['biz_name'] as String,
      location: json['bss_location'] as String,
      phone: json['contct_no'] as String,
    );

Map<String, dynamic> _$$BusinessImplToJson(_$BusinessImpl instance) =>
    <String, dynamic>{
      'biz_name': instance.name,
      'bss_location': instance.location,
      'contct_no': instance.phone,
    };
