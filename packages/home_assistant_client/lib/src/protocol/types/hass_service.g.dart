// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hass_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HassDomainServices _$HassDomainServicesFromJson(Map<String, dynamic> json) =>
    _HassDomainServices(
      (json['services'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, HassService.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$HassDomainServicesToJson(_HassDomainServices instance) =>
    <String, dynamic>{'services': instance.services};

_HassServices _$HassServicesFromJson(Map<String, dynamic> json) =>
    _HassServices(
      (json['domains'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, HassDomainServices.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$HassServicesToJson(_HassServices instance) =>
    <String, dynamic>{'domains': instance.domains};

_HassService _$HassServiceFromJson(Map<String, dynamic> json) => _HassService(
  name: json['name'] as String?,
  description: json['description'] as String?,
  target: json['target'] as Map<String, dynamic>?,
  fields: (json['fields'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, Field.fromJson(e as Map<String, dynamic>)),
  ),
  response: json['response'] == null
      ? null
      : Response.fromJson(json['response'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HassServiceToJson(_HassService instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'target': instance.target,
      'fields': instance.fields,
      'response': instance.response,
    };

_Field _$FieldFromJson(Map<String, dynamic> json) => _Field(
  name: json['name'] as String? ?? '',
  description: json['description'] as String? ?? '',
  example: json['example'],
  selector: json['selector'] as Map<String, dynamic>?,
  filter: json['filter'] == null
      ? null
      : FieldFilter.fromJson(json['filter'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FieldToJson(_Field instance) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'example': instance.example,
  'selector': instance.selector,
  'filter': instance.filter,
};

_FieldFilter _$FieldFilterFromJson(Map<String, dynamic> json) => _FieldFilter(
  (json['supported_features'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  json['attribute'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$FieldFilterToJson(_FieldFilter instance) =>
    <String, dynamic>{
      'supported_features': instance.supported_features,
      'attribute': instance.attribute,
    };

_Response _$ResponseFromJson(Map<String, dynamic> json) =>
    _Response(optional: json['optional'] as bool);

Map<String, dynamic> _$ResponseToJson(_Response instance) => <String, dynamic>{
  'optional': instance.optional,
};
