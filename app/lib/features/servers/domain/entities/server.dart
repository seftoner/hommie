import 'package:hommie/features/common/domain/entities/ha_version.dart';
import 'package:hommie/features/common/domain/values/server_url.dart';

class Server {
  static const String defaultName = 'My home';

  final int? id;
  final ServerUrl? baseUrl;
  final String? internalUrl;
  final String? externalUrl;
  final String name;
  final HaVersion? version;

  const Server({
    this.id,
    required this.name,
    this.version,
    this.baseUrl,
    this.internalUrl,
    this.externalUrl,
  });

  const Server.temporary({required this.baseUrl})
    : id = null,
      name = defaultName,
      version = null,
      internalUrl = null,
      externalUrl = null;

  //In the future here will addition logic to properly resolve url base on settings.
  String get url {
    final effectiveInternalOrExternalUrl =
        internalUrl ?? externalUrl ?? baseUrl?.value.getOrElse((_) => '');

    if (effectiveInternalOrExternalUrl == null) {
      throw const FormatException('No valid URL found in TXT record.');
    }

    return effectiveInternalOrExternalUrl;
  }

  Server copyWith({
    int? id,
    String? url,
    String? name,
    String? token,
    String? internalUrl,
    String? externalUrl,
    HaVersion? version,
  }) {
    return Server(
      id: id ?? this.id,
      baseUrl: baseUrl,
      internalUrl: internalUrl,
      externalUrl: externalUrl,
      name: name ?? this.name,
      version: version ?? this.version,
    );
  }
}
