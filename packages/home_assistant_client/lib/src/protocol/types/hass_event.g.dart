// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hass_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EntityStateRemove _$EntityStateRemoveFromJson(Map<String, dynamic> json) =>
    _EntityStateRemove(
      (json['a'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$EntityStateRemoveToJson(_EntityStateRemove instance) =>
    <String, dynamic>{'a': instance.a};

_EntityState _$EntityStateFromJson(Map<String, dynamic> json) => _EntityState(
  state: json['s'] as String?,
  attributes: json['a'] as Map<String, dynamic>?,
  context: json['c'] == null ? null : Context.fromJson(json['c']),
  last_changed: (json['lc'] as num?)?.toDouble(),
  last_updated: (json['lu'] as num?)?.toDouble(),
);

Map<String, dynamic> _$EntityStateToJson(_EntityState instance) =>
    <String, dynamic>{
      's': instance.state,
      'a': instance.attributes,
      'c': instance.context,
      'lc': instance.last_changed,
      'lu': instance.last_updated,
    };

_EntityDiff _$EntityDiffFromJson(Map<String, dynamic> json) => _EntityDiff(
  add: json['+'] == null
      ? null
      : EntityState.fromJson(json['+'] as Map<String, dynamic>),
  remove: json['-'] == null
      ? null
      : EntityStateRemove.fromJson(json['-'] as Map<String, dynamic>),
);

Map<String, dynamic> _$EntityDiffToJson(_EntityDiff instance) =>
    <String, dynamic>{'+': instance.add, '-': instance.remove};

_StatesUpdates _$StatesUpdatesFromJson(Map<String, dynamic> json) =>
    _StatesUpdates(
      add: (json['a'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, EntityState.fromJson(e as Map<String, dynamic>)),
      ),
      remove: (json['r'] as List<dynamic>?)?.map((e) => e as String).toList(),
      change: (json['c'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, EntityDiff.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$StatesUpdatesToJson(_StatesUpdates instance) =>
    <String, dynamic>{
      'a': instance.add,
      'r': instance.remove,
      'c': instance.change,
    };

_CallServiceResponse _$CallServiceResponseFromJson(Map<String, dynamic> json) =>
    _CallServiceResponse(
      context: Context.fromJson(json['context']),
      response: json['response'],
    );

Map<String, dynamic> _$CallServiceResponseToJson(
  _CallServiceResponse instance,
) => <String, dynamic>{
  'context': instance.context,
  'response': instance.response,
};

_Context _$ContextFromJson(Map<String, dynamic> json) => _Context(
  id: json['id'] as String,
  user_id: json['user_id'] as String?,
  parent_id: json['parent_id'] as String?,
);

Map<String, dynamic> _$ContextToJson(_Context instance) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.user_id,
  'parent_id': instance.parent_id,
};

_HassEvent _$HassEventFromJson(Map<String, dynamic> json) => _HassEvent(
  context: Context.fromJson(json['context']),
  origin: json['origin'] as String,
  time_fired: json['time_fired'] as String,
  event_type: json['event_type'] as String,
  data: json['data'] as Map<String, dynamic>,
);

Map<String, dynamic> _$HassEventToJson(_HassEvent instance) =>
    <String, dynamic>{
      'context': instance.context,
      'origin': instance.origin,
      'time_fired': instance.time_fired,
      'event_type': instance.event_type,
      'data': instance.data,
    };

_HassEntity _$HassEntityFromJson(Map<String, dynamic> json) => _HassEntity(
  entity_id: json['entity_id'] as String,
  state: json['state'] as String,
  last_changed: json['last_changed'] as String,
  last_updated: json['last_updated'] as String,
  attributes: json['attributes'] as Map<String, dynamic>,
  context: Context.fromJson(json['context']),
);

Map<String, dynamic> _$HassEntityToJson(_HassEntity instance) =>
    <String, dynamic>{
      'entity_id': instance.entity_id,
      'state': instance.state,
      'last_changed': instance.last_changed,
      'last_updated': instance.last_updated,
      'attributes': instance.attributes,
      'context': instance.context,
    };
