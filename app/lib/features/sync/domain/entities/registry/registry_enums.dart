import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(valueField: 'code')
enum EntityCategory {
  config('config'),
  diagnostic('diagnostic');

  const EntityCategory(this.code);
  final String code;
}

@JsonEnum(valueField: 'code')
enum DeviceRegistryEntryType {
  service('service');

  const DeviceRegistryEntryType(this.code);
  final String code;
}

@JsonEnum(valueField: 'code')
enum DeviceRegistryDisabledBy {
  user('user'),
  integration('integration'),
  configEntry('config_entry');

  const DeviceRegistryDisabledBy(this.code);
  final String code;
}

@JsonEnum(valueField: 'code')
enum EntityRegistryDisabledBy {
  user('user'),
  device('device'),
  integration('integration'),
  configEntry('config_entry');

  const EntityRegistryDisabledBy(this.code);
  final String code;
}

@JsonEnum(valueField: 'code')
enum EntityRegistryHiddenBy {
  user('user'),
  device('device'),
  integration('integration');

  const EntityRegistryHiddenBy(this.code);
  final String code;
}
