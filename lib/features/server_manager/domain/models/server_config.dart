class ServerConfig {
  final int id;
  final String uri;
  final String name;
  final bool isActive;
  // final String accessToken;

  const ServerConfig({
    required this.id,
    required this.uri,
    required this.name,
    this.isActive = false,
    // required this.accessToken,
  });

  ServerConfig copyWith({
    int? id,
    String? url,
    String? name,
    String? token,
    bool? isActive,
  }) {
    return ServerConfig(
      id: id ?? this.id,
      uri: uri,
      name: name ?? this.name,
      // token: token ?? this.token,
      isActive: isActive ?? this.isActive,
    );
  }
}
