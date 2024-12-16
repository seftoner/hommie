// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hass_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HassDomainServicesImpl _$$HassDomainServicesImplFromJson(
        Map<String, dynamic> json) =>
    _$HassDomainServicesImpl(
      (json['services'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, HassService.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$HassDomainServicesImplToJson(
        _$HassDomainServicesImpl instance) =>
    <String, dynamic>{
      'services': instance.services,
    };

_$HassServicesImpl _$$HassServicesImplFromJson(Map<String, dynamic> json) =>
    _$HassServicesImpl(
      (json['domains'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, HassDomainServices.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$HassServicesImplToJson(_$HassServicesImpl instance) =>
    <String, dynamic>{
      'domains': instance.domains,
    };

_$HassServiceImpl _$$HassServiceImplFromJson(Map<String, dynamic> json) =>
    _$HassServiceImpl(
      name: json['name'] as String?,
      description: json['description'] as String,
      target: json['target'] as Map<String, dynamic>?,
      fields: (json['fields'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Field.fromJson(e as Map<String, dynamic>)),
      ),
      response: json['response'] == null
          ? null
          : Response.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$HassServiceImplToJson(_$HassServiceImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'target': instance.target,
      'fields': instance.fields,
      'response': instance.response,
    };

_$FieldImpl _$$FieldImplFromJson(Map<String, dynamic> json) => _$FieldImpl(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      example: json['example'],
      selector: json['selector'] as Map<String, dynamic>?,
      filter: json['filter'] == null
          ? null
          : FieldFilter.fromJson(json['filter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FieldImplToJson(_$FieldImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'example': instance.example,
      'selector': instance.selector,
      'filter': instance.filter,
    };

_$FieldFilterImpl _$$FieldFilterImplFromJson(Map<String, dynamic> json) =>
    _$FieldFilterImpl(
      (json['supported_features'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      json['attribute'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$FieldFilterImplToJson(_$FieldFilterImpl instance) =>
    <String, dynamic>{
      'supported_features': instance.supported_features,
      'attribute': instance.attribute,
    };

_$ResponseImpl _$$ResponseImplFromJson(Map<String, dynamic> json) =>
    _$ResponseImpl(
      optional: json['optional'] as bool,
    );

Map<String, dynamic> _$$ResponseImplToJson(_$ResponseImpl instance) =>
    <String, dynamic>{
      'optional': instance.optional,
    };
