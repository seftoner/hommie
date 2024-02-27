typedef Json = Map<String, dynamic>;
typedef JsonMapper<T> = T Function(Json);

extension FutureMappingExtension on Future<dynamic> {
  Future<T> mapItem<T>(JsonMapper<T> fromJson) {
    return then((value) => fromJson(value));
  }

  Future<List<T>> mapList<T>(JsonMapper<T> fromJson) {
    return then(
        (value) => (value as List<dynamic>).map((e) => fromJson(e)).toList());
  }
}
