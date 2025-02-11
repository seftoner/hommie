import 'package:hommie/features/auth/domain/entities/ha_version.dart';

class HaServerConfig {
  static String defaultName = 'My home';

  final int id;
  final String? baseUrl;
  final String? internalUrl;
  final String? externalUrl;
  final String name;
  final bool isActive;
  final HaVersion? version;

  const HaServerConfig({
    required this.id,
    required this.name,
    this.isActive = false,
    this.version,
    this.baseUrl,
    this.internalUrl,
    this.externalUrl,
  });

  //In future here will addition logic to properly resolve url base on settings.
  String get url {
    final effectiveInternalOrExternalUrl =
        internalUrl ?? externalUrl ?? baseUrl;

    if (effectiveInternalOrExternalUrl == null) {
      throw const FormatException('No valid URL found in TXT record.');
    }

    return effectiveInternalOrExternalUrl;
  }

  HaServerConfig copyWith({
    int? id,
    String? url,
    String? name,
    String? token,
    bool? isActive,
    String? internalUrl,
    String? externalUrl,
    HaVersion? version,
  }) {
    return HaServerConfig(
      id: id ?? this.id,
      baseUrl: baseUrl,
      internalUrl: internalUrl,
      externalUrl: externalUrl,
      name: name ?? this.name,
      version: version ?? this.version,
      isActive: isActive ?? this.isActive,
    );
  }
}
