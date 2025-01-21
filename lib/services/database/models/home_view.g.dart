// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHomeViewConfigCollection on Isar {
  IsarCollection<HomeViewConfig> get homeViewConfigs => this.collection();
}

const HomeViewConfigSchema = CollectionSchema(
  name: r'HomeViewConfig',
  id: -88698802296639949,
  properties: {},
  estimateSize: _homeViewConfigEstimateSize,
  serialize: _homeViewConfigSerialize,
  deserialize: _homeViewConfigDeserialize,
  deserializeProp: _homeViewConfigDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'haServer': LinkSchema(
      id: -3828495337796609846,
      name: r'haServer',
      target: r'HaServer',
      single: true,
    ),
    r'areaConfigs': LinkSchema(
      id: -8827963395838390834,
      name: r'areaConfigs',
      target: r'AreaHomeConfig',
      single: false,
      linkName: r'homeConfig',
    )
  },
  embeddedSchemas: {},
  getId: _homeViewConfigGetId,
  getLinks: _homeViewConfigGetLinks,
  attach: _homeViewConfigAttach,
  version: '3.1.8',
);

int _homeViewConfigEstimateSize(
  HomeViewConfig object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _homeViewConfigSerialize(
  HomeViewConfig object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {}
HomeViewConfig _homeViewConfigDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HomeViewConfig();
  object.id = id;
  return object;
}

P _homeViewConfigDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _homeViewConfigGetId(HomeViewConfig object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _homeViewConfigGetLinks(HomeViewConfig object) {
  return [object.haServer, object.areaConfigs];
}

void _homeViewConfigAttach(
    IsarCollection<dynamic> col, Id id, HomeViewConfig object) {
  object.id = id;
  object.haServer.attach(col, col.isar.collection<HaServer>(), r'haServer', id);
  object.areaConfigs
      .attach(col, col.isar.collection<AreaHomeConfig>(), r'areaConfigs', id);
}

extension HomeViewConfigQueryWhereSort
    on QueryBuilder<HomeViewConfig, HomeViewConfig, QWhere> {
  QueryBuilder<HomeViewConfig, HomeViewConfig, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension HomeViewConfigQueryWhere
    on QueryBuilder<HomeViewConfig, HomeViewConfig, QWhereClause> {
  QueryBuilder<HomeViewConfig, HomeViewConfig, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<HomeViewConfig, HomeViewConfig, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<HomeViewConfig, HomeViewConfig, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<HomeViewConfig, HomeViewConfig, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<HomeViewConfig, HomeViewConfig, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension HomeViewConfigQueryFilter
    on QueryBuilder<HomeViewConfig, HomeViewConfig, QFilterCondition> {
  QueryBuilder<HomeViewConfig, HomeViewConfig, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HomeViewConfig, HomeViewConfig, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HomeViewConfig, HomeViewConfig, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HomeViewConfig, HomeViewConfig, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension HomeViewConfigQueryObject
    on QueryBuilder<HomeViewConfig, HomeViewConfig, QFilterCondition> {}

extension HomeViewConfigQueryLinks
    on QueryBuilder<HomeViewConfig, HomeViewConfig, QFilterCondition> {
  QueryBuilder<HomeViewConfig, HomeViewConfig, QAfterFilterCondition> haServer(
      FilterQuery<HaServer> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'haServer');
    });
  }

  QueryBuilder<HomeViewConfig, HomeViewConfig, QAfterFilterCondition>
      haServerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'haServer', 0, true, 0, true);
    });
  }

  QueryBuilder<HomeViewConfig, HomeViewConfig, QAfterFilterCondition>
      areaConfigs(FilterQuery<AreaHomeConfig> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'areaConfigs');
    });
  }

  QueryBuilder<HomeViewConfig, HomeViewConfig, QAfterFilterCondition>
      areaConfigsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'areaConfigs', length, true, length, true);
    });
  }

  QueryBuilder<HomeViewConfig, HomeViewConfig, QAfterFilterCondition>
      areaConfigsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'areaConfigs', 0, true, 0, true);
    });
  }

  QueryBuilder<HomeViewConfig, HomeViewConfig, QAfterFilterCondition>
      areaConfigsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'areaConfigs', 0, false, 999999, true);
    });
  }

  QueryBuilder<HomeViewConfig, HomeViewConfig, QAfterFilterCondition>
      areaConfigsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'areaConfigs', 0, true, length, include);
    });
  }

  QueryBuilder<HomeViewConfig, HomeViewConfig, QAfterFilterCondition>
      areaConfigsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'areaConfigs', length, include, 999999, true);
    });
  }

  QueryBuilder<HomeViewConfig, HomeViewConfig, QAfterFilterCondition>
      areaConfigsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'areaConfigs', lower, includeLower, upper, includeUpper);
    });
  }
}

extension HomeViewConfigQuerySortBy
    on QueryBuilder<HomeViewConfig, HomeViewConfig, QSortBy> {}

extension HomeViewConfigQuerySortThenBy
    on QueryBuilder<HomeViewConfig, HomeViewConfig, QSortThenBy> {
  QueryBuilder<HomeViewConfig, HomeViewConfig, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HomeViewConfig, HomeViewConfig, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension HomeViewConfigQueryWhereDistinct
    on QueryBuilder<HomeViewConfig, HomeViewConfig, QDistinct> {}

extension HomeViewConfigQueryProperty
    on QueryBuilder<HomeViewConfig, HomeViewConfig, QQueryProperty> {
  QueryBuilder<HomeViewConfig, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAreaHomeConfigCollection on Isar {
  IsarCollection<AreaHomeConfig> get areaHomeConfigs => this.collection();
}

const AreaHomeConfigSchema = CollectionSchema(
  name: r'AreaHomeConfig',
  id: -8144881742978909942,
  properties: {
    r'position': PropertySchema(
      id: 0,
      name: r'position',
      type: IsarType.long,
    )
  },
  estimateSize: _areaHomeConfigEstimateSize,
  serialize: _areaHomeConfigSerialize,
  deserialize: _areaHomeConfigDeserialize,
  deserializeProp: _areaHomeConfigDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'area': LinkSchema(
      id: 226839567268489173,
      name: r'area',
      target: r'Area',
      single: true,
    ),
    r'homeConfig': LinkSchema(
      id: 6198070494960723579,
      name: r'homeConfig',
      target: r'HomeViewConfig',
      single: true,
    ),
    r'deviceConfigs': LinkSchema(
      id: -2033022881605892564,
      name: r'deviceConfigs',
      target: r'DeviceHomeConfig',
      single: false,
      linkName: r'areaConfig',
    )
  },
  embeddedSchemas: {},
  getId: _areaHomeConfigGetId,
  getLinks: _areaHomeConfigGetLinks,
  attach: _areaHomeConfigAttach,
  version: '3.1.8',
);

int _areaHomeConfigEstimateSize(
  AreaHomeConfig object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _areaHomeConfigSerialize(
  AreaHomeConfig object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.position);
}

AreaHomeConfig _areaHomeConfigDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AreaHomeConfig(
    position: reader.readLong(offsets[0]),
  );
  object.id = id;
  return object;
}

P _areaHomeConfigDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _areaHomeConfigGetId(AreaHomeConfig object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _areaHomeConfigGetLinks(AreaHomeConfig object) {
  return [object.area, object.homeConfig, object.deviceConfigs];
}

void _areaHomeConfigAttach(
    IsarCollection<dynamic> col, Id id, AreaHomeConfig object) {
  object.id = id;
  object.area.attach(col, col.isar.collection<Area>(), r'area', id);
  object.homeConfig
      .attach(col, col.isar.collection<HomeViewConfig>(), r'homeConfig', id);
  object.deviceConfigs.attach(
      col, col.isar.collection<DeviceHomeConfig>(), r'deviceConfigs', id);
}

extension AreaHomeConfigQueryWhereSort
    on QueryBuilder<AreaHomeConfig, AreaHomeConfig, QWhere> {
  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AreaHomeConfigQueryWhere
    on QueryBuilder<AreaHomeConfig, AreaHomeConfig, QWhereClause> {
  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AreaHomeConfigQueryFilter
    on QueryBuilder<AreaHomeConfig, AreaHomeConfig, QFilterCondition> {
  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterFilterCondition>
      positionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterFilterCondition>
      positionGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterFilterCondition>
      positionLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterFilterCondition>
      positionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'position',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AreaHomeConfigQueryObject
    on QueryBuilder<AreaHomeConfig, AreaHomeConfig, QFilterCondition> {}

extension AreaHomeConfigQueryLinks
    on QueryBuilder<AreaHomeConfig, AreaHomeConfig, QFilterCondition> {
  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterFilterCondition> area(
      FilterQuery<Area> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'area');
    });
  }

  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterFilterCondition>
      areaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'area', 0, true, 0, true);
    });
  }

  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterFilterCondition>
      homeConfig(FilterQuery<HomeViewConfig> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'homeConfig');
    });
  }

  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterFilterCondition>
      homeConfigIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'homeConfig', 0, true, 0, true);
    });
  }

  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterFilterCondition>
      deviceConfigs(FilterQuery<DeviceHomeConfig> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'deviceConfigs');
    });
  }

  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterFilterCondition>
      deviceConfigsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'deviceConfigs', length, true, length, true);
    });
  }

  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterFilterCondition>
      deviceConfigsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'deviceConfigs', 0, true, 0, true);
    });
  }

  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterFilterCondition>
      deviceConfigsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'deviceConfigs', 0, false, 999999, true);
    });
  }

  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterFilterCondition>
      deviceConfigsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'deviceConfigs', 0, true, length, include);
    });
  }

  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterFilterCondition>
      deviceConfigsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'deviceConfigs', length, include, 999999, true);
    });
  }

  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterFilterCondition>
      deviceConfigsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'deviceConfigs', lower, includeLower, upper, includeUpper);
    });
  }
}

extension AreaHomeConfigQuerySortBy
    on QueryBuilder<AreaHomeConfig, AreaHomeConfig, QSortBy> {
  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterSortBy> sortByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.asc);
    });
  }

  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterSortBy>
      sortByPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.desc);
    });
  }
}

extension AreaHomeConfigQuerySortThenBy
    on QueryBuilder<AreaHomeConfig, AreaHomeConfig, QSortThenBy> {
  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterSortBy> thenByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.asc);
    });
  }

  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QAfterSortBy>
      thenByPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.desc);
    });
  }
}

extension AreaHomeConfigQueryWhereDistinct
    on QueryBuilder<AreaHomeConfig, AreaHomeConfig, QDistinct> {
  QueryBuilder<AreaHomeConfig, AreaHomeConfig, QDistinct> distinctByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'position');
    });
  }
}

extension AreaHomeConfigQueryProperty
    on QueryBuilder<AreaHomeConfig, AreaHomeConfig, QQueryProperty> {
  QueryBuilder<AreaHomeConfig, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AreaHomeConfig, int, QQueryOperations> positionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'position');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDeviceHomeConfigCollection on Isar {
  IsarCollection<DeviceHomeConfig> get deviceHomeConfigs => this.collection();
}

const DeviceHomeConfigSchema = CollectionSchema(
  name: r'DeviceHomeConfig',
  id: 1605330354188062233,
  properties: {
    r'position': PropertySchema(
      id: 0,
      name: r'position',
      type: IsarType.long,
    ),
    r'size': PropertySchema(
      id: 1,
      name: r'size',
      type: IsarType.byte,
      enumMap: _DeviceHomeConfigsizeEnumValueMap,
    )
  },
  estimateSize: _deviceHomeConfigEstimateSize,
  serialize: _deviceHomeConfigSerialize,
  deserialize: _deviceHomeConfigDeserialize,
  deserializeProp: _deviceHomeConfigDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'device': LinkSchema(
      id: 6235099333004358942,
      name: r'device',
      target: r'Device',
      single: true,
    ),
    r'areaConfig': LinkSchema(
      id: -2245599139310282896,
      name: r'areaConfig',
      target: r'AreaHomeConfig',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _deviceHomeConfigGetId,
  getLinks: _deviceHomeConfigGetLinks,
  attach: _deviceHomeConfigAttach,
  version: '3.1.8',
);

int _deviceHomeConfigEstimateSize(
  DeviceHomeConfig object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _deviceHomeConfigSerialize(
  DeviceHomeConfig object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.position);
  writer.writeByte(offsets[1], object.size.index);
}

DeviceHomeConfig _deviceHomeConfigDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DeviceHomeConfig(
    position: reader.readLong(offsets[0]),
    size:
        _DeviceHomeConfigsizeValueEnumMap[reader.readByteOrNull(offsets[1])] ??
            DeviceDisplaySize.small,
  );
  object.id = id;
  return object;
}

P _deviceHomeConfigDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (_DeviceHomeConfigsizeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          DeviceDisplaySize.small) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _DeviceHomeConfigsizeEnumValueMap = {
  'small': 0,
  'big': 1,
};
const _DeviceHomeConfigsizeValueEnumMap = {
  0: DeviceDisplaySize.small,
  1: DeviceDisplaySize.big,
};

Id _deviceHomeConfigGetId(DeviceHomeConfig object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _deviceHomeConfigGetLinks(DeviceHomeConfig object) {
  return [object.device, object.areaConfig];
}

void _deviceHomeConfigAttach(
    IsarCollection<dynamic> col, Id id, DeviceHomeConfig object) {
  object.id = id;
  object.device.attach(col, col.isar.collection<Device>(), r'device', id);
  object.areaConfig
      .attach(col, col.isar.collection<AreaHomeConfig>(), r'areaConfig', id);
}

extension DeviceHomeConfigQueryWhereSort
    on QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QWhere> {
  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DeviceHomeConfigQueryWhere
    on QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QWhereClause> {
  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DeviceHomeConfigQueryFilter
    on QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QFilterCondition> {
  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterFilterCondition>
      positionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterFilterCondition>
      positionGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterFilterCondition>
      positionLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterFilterCondition>
      positionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'position',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterFilterCondition>
      sizeEqualTo(DeviceDisplaySize value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'size',
        value: value,
      ));
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterFilterCondition>
      sizeGreaterThan(
    DeviceDisplaySize value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'size',
        value: value,
      ));
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterFilterCondition>
      sizeLessThan(
    DeviceDisplaySize value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'size',
        value: value,
      ));
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterFilterCondition>
      sizeBetween(
    DeviceDisplaySize lower,
    DeviceDisplaySize upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'size',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DeviceHomeConfigQueryObject
    on QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QFilterCondition> {}

extension DeviceHomeConfigQueryLinks
    on QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QFilterCondition> {
  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterFilterCondition>
      device(FilterQuery<Device> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'device');
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterFilterCondition>
      deviceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'device', 0, true, 0, true);
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterFilterCondition>
      areaConfig(FilterQuery<AreaHomeConfig> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'areaConfig');
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterFilterCondition>
      areaConfigIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'areaConfig', 0, true, 0, true);
    });
  }
}

extension DeviceHomeConfigQuerySortBy
    on QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QSortBy> {
  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterSortBy>
      sortByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.asc);
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterSortBy>
      sortByPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.desc);
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterSortBy> sortBySize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'size', Sort.asc);
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterSortBy>
      sortBySizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'size', Sort.desc);
    });
  }
}

extension DeviceHomeConfigQuerySortThenBy
    on QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QSortThenBy> {
  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterSortBy>
      thenByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.asc);
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterSortBy>
      thenByPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.desc);
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterSortBy> thenBySize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'size', Sort.asc);
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QAfterSortBy>
      thenBySizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'size', Sort.desc);
    });
  }
}

extension DeviceHomeConfigQueryWhereDistinct
    on QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QDistinct> {
  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QDistinct>
      distinctByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'position');
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QDistinct> distinctBySize() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'size');
    });
  }
}

extension DeviceHomeConfigQueryProperty
    on QueryBuilder<DeviceHomeConfig, DeviceHomeConfig, QQueryProperty> {
  QueryBuilder<DeviceHomeConfig, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DeviceHomeConfig, int, QQueryOperations> positionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'position');
    });
  }

  QueryBuilder<DeviceHomeConfig, DeviceDisplaySize, QQueryOperations>
      sizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'size');
    });
  }
}
