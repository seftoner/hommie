import 'package:freezed_annotation/freezed_annotation.dart';
part 'hass_service.freezed.dart';
part 'hass_service.g.dart';

@freezed
sealed class HassDomainServices with _$HassDomainServices {
  factory HassDomainServices(Map<String, HassService> services) =
      _HassDomainServices;

  factory HassDomainServices.fromJson(Map<String, dynamic> json) =>
      const HassDomainServicesConverter().fromJson(json);
}

class HassDomainServicesConverter
    implements JsonConverter<HassDomainServices, Map<String, dynamic>> {
  const HassDomainServicesConverter();
  @override
  HassDomainServices fromJson(Map<String, dynamic> json) {
    final services = <String, HassService>{};

    json.forEach((key, serviceJson) {
      services[key] = HassService.fromJson(serviceJson);
    });

    return HassDomainServices(services);
  }

  @override
  Map<String, dynamic> toJson(HassDomainServices object) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

@freezed
sealed class HassServices with _$HassServices {
  factory HassServices(Map<String, HassDomainServices> domains) = _HassServices;

  factory HassServices.fromJson(Map<String, dynamic> json) =>
      const HassServicesConverter().fromJson(json);
}

class HassServicesConverter
    implements JsonConverter<HassServices, Map<String, dynamic>> {
  const HassServicesConverter();

  @override
  HassServices fromJson(Map<String, dynamic> json) {
    final domains = <String, HassDomainServices>{};

    json.forEach((key, serviceJson) {
      domains[key] = HassDomainServices.fromJson(serviceJson);
    });

    return HassServices(domains);
  }

  @override
  Map<String, dynamic> toJson(HassServices object) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

@freezed
sealed class HassService with _$HassService {
  const factory HassService({
    String? name,
    required String description,
    Map<String, dynamic>? target,
    required Map<String, Field> fields,
    Response? response,
  }) = _HassService;

  factory HassService.fromJson(Map<String, dynamic> json) =>
      _$HassServiceFromJson(json);
}

@freezed
sealed class Field with _$Field {
  const factory Field({
    @Default('') String? name,
    @Default('') String? description,
    dynamic example,
    Map<String, dynamic>? selector,
    FieldFilter? filter,
  }) = _Field;

  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);
}

@freezed
sealed class FieldFilter with _$FieldFilter {
  factory FieldFilter(
    // ignore: non_constant_identifier_names
    List<int>? supported_features,
    Map<String, dynamic>? attribute,
  ) = _FieldFilter;

  factory FieldFilter.fromJson(Map<String, dynamic> json) =>
      _$FieldFilterFromJson(json);
}

@freezed
sealed class Response with _$Response {
  const factory Response({required bool optional}) = _Response;

  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);
}
