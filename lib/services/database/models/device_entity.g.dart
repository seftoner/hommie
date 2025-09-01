// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDeviceEntityCollection on Isar {
  IsarCollection<DeviceEntity> get deviceEntitys => this.collection();
}

const DeviceEntitySchema = CollectionSchema(
  name: r'DeviceEntity',
  id: 6626679775157521336,
  properties: {
    r'haId': PropertySchema(id: 0, name: r'haId', type: IsarType.string),
    r'name': PropertySchema(id: 1, name: r'name', type: IsarType.string),
    r'type': PropertySchema(id: 2, name: r'type', type: IsarType.string),
  },

  estimateSize: _deviceEntityEstimateSize,
  serialize: _deviceEntitySerialize,
  deserialize: _deviceEntityDeserialize,
  deserializeProp: _deviceEntityDeserializeProp,
  idName: r'id',
  indexes: {
    r'haId': IndexSchema(
      id: 8320385079685986086,
      name: r'haId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'haId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {
    r'area': LinkSchema(
      id: -6778084918978566623,
      name: r'area',
      target: r'AreaEntity',
      single: true,
    ),
  },
  embeddedSchemas: {},

  getId: _deviceEntityGetId,
  getLinks: _deviceEntityGetLinks,
  attach: _deviceEntityAttach,
  version: '3.2.0-dev.2',
);

int _deviceEntityEstimateSize(
  DeviceEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.haId.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.type.length * 3;
  return bytesCount;
}

void _deviceEntitySerialize(
  DeviceEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.haId);
  writer.writeString(offsets[1], object.name);
  writer.writeString(offsets[2], object.type);
}

DeviceEntity _deviceEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DeviceEntity(
    haId: reader.readString(offsets[0]),
    name: reader.readString(offsets[1]),
    type: reader.readString(offsets[2]),
  );
  object.id = id;
  return object;
}

P _deviceEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _deviceEntityGetId(DeviceEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _deviceEntityGetLinks(DeviceEntity object) {
  return [object.area];
}

void _deviceEntityAttach(
  IsarCollection<dynamic> col,
  Id id,
  DeviceEntity object,
) {
  object.id = id;
  object.area.attach(col, col.isar.collection<AreaEntity>(), r'area', id);
}

extension DeviceEntityByIndex on IsarCollection<DeviceEntity> {
  Future<DeviceEntity?> getByHaId(String haId) {
    return getByIndex(r'haId', [haId]);
  }

  DeviceEntity? getByHaIdSync(String haId) {
    return getByIndexSync(r'haId', [haId]);
  }

  Future<bool> deleteByHaId(String haId) {
    return deleteByIndex(r'haId', [haId]);
  }

  bool deleteByHaIdSync(String haId) {
    return deleteByIndexSync(r'haId', [haId]);
  }

  Future<List<DeviceEntity?>> getAllByHaId(List<String> haIdValues) {
    final values = haIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'haId', values);
  }

  List<DeviceEntity?> getAllByHaIdSync(List<String> haIdValues) {
    final values = haIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'haId', values);
  }

  Future<int> deleteAllByHaId(List<String> haIdValues) {
    final values = haIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'haId', values);
  }

  int deleteAllByHaIdSync(List<String> haIdValues) {
    final values = haIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'haId', values);
  }

  Future<Id> putByHaId(DeviceEntity object) {
    return putByIndex(r'haId', object);
  }

  Id putByHaIdSync(DeviceEntity object, {bool saveLinks = true}) {
    return putByIndexSync(r'haId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByHaId(List<DeviceEntity> objects) {
    return putAllByIndex(r'haId', objects);
  }

  List<Id> putAllByHaIdSync(
    List<DeviceEntity> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'haId', objects, saveLinks: saveLinks);
  }
}

extension DeviceEntityQueryWhereSort
    on QueryBuilder<DeviceEntity, DeviceEntity, QWhere> {
  QueryBuilder<DeviceEntity, DeviceEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DeviceEntityQueryWhere
    on QueryBuilder<DeviceEntity, DeviceEntity, QWhereClause> {
  QueryBuilder<DeviceEntity, DeviceEntity, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
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

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterWhereClause> haIdEqualTo(
    String haId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'haId', value: [haId]),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterWhereClause> haIdNotEqualTo(
    String haId,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'haId',
                lower: [],
                upper: [haId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'haId',
                lower: [haId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'haId',
                lower: [haId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'haId',
                lower: [],
                upper: [haId],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension DeviceEntityQueryFilter
    on QueryBuilder<DeviceEntity, DeviceEntity, QFilterCondition> {
  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> haIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'haId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
  haIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'haId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> haIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'haId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> haIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'haId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
  haIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'haId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> haIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'haId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> haIdContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'haId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> haIdMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'haId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
  haIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'haId', value: ''),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
  haIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'haId', value: ''),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
  nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'name',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
  nameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> nameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> nameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'name',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
  nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
  nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
  typeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> typeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> typeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'type',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
  typeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> typeContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> typeMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'type',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
  typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'type', value: ''),
      );
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition>
  typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'type', value: ''),
      );
    });
  }
}

extension DeviceEntityQueryObject
    on QueryBuilder<DeviceEntity, DeviceEntity, QFilterCondition> {}

extension DeviceEntityQueryLinks
    on QueryBuilder<DeviceEntity, DeviceEntity, QFilterCondition> {
  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> area(
    FilterQuery<AreaEntity> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'area');
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterFilterCondition> areaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'area', 0, true, 0, true);
    });
  }
}

extension DeviceEntityQuerySortBy
    on QueryBuilder<DeviceEntity, DeviceEntity, QSortBy> {
  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy> sortByHaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'haId', Sort.asc);
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy> sortByHaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'haId', Sort.desc);
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension DeviceEntityQuerySortThenBy
    on QueryBuilder<DeviceEntity, DeviceEntity, QSortThenBy> {
  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy> thenByHaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'haId', Sort.asc);
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy> thenByHaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'haId', Sort.desc);
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension DeviceEntityQueryWhereDistinct
    on QueryBuilder<DeviceEntity, DeviceEntity, QDistinct> {
  QueryBuilder<DeviceEntity, DeviceEntity, QDistinct> distinctByHaId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'haId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QDistinct> distinctByName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DeviceEntity, DeviceEntity, QDistinct> distinctByType({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension DeviceEntityQueryProperty
    on QueryBuilder<DeviceEntity, DeviceEntity, QQueryProperty> {
  QueryBuilder<DeviceEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DeviceEntity, String, QQueryOperations> haIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'haId');
    });
  }

  QueryBuilder<DeviceEntity, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<DeviceEntity, String, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
