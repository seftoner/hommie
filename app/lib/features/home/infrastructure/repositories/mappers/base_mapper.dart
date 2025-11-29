abstract class BaseMapper<TDomain, TDatabase> {
  TDomain fromDatabase(TDatabase entity);
  TDatabase toDatabase(TDomain entity);
}

extension IsarMappingList<T> on Future<List<T>> {
  Future<List<R>> mapWith<R>(R Function(T) mapper) {
    return then((list) => list.map(mapper).toList());
  }
}

extension IsarMapping<T> on Future<T> {
  Future<R> mapWith<R>(R Function(T) mapper) {
    return then((value) => mapper(value));
  }
}

extension NullableIsarMapping<T> on Future<T?> {
  Future<R?> mapWithNullable<R>(R Function(T) mapper) {
    return then((value) => value != null ? mapper(value) : null);
  }
}
