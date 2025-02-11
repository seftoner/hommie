// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAreaEntityCollection on Isar {
  IsarCollection<AreaEntity> get areaEntitys => this.collection();
}

const AreaEntitySchema = CollectionSchema(
  name: r'AreaEntity',
  id: 4784257270551015158,
  properties: {
    r'background': PropertySchema(
      id: 0,
      name: r'background',
      type: IsarType.string,
    ),
    r'haId': PropertySchema(
      id: 1,
      name: r'haId',
      type: IsarType.string,
    ),
    r'image': PropertySchema(
      id: 2,
      name: r'image',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _areaEntityEstimateSize,
  serialize: _areaEntitySerialize,
  deserialize: _areaEntityDeserialize,
  deserializeProp: _areaEntityDeserializeProp,
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
        )
      ],
    ),
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {
    r'devices': LinkSchema(
      id: -1323198386073066508,
      name: r'devices',
      target: r'DeviceEntity',
      single: false,
      linkName: r'area',
    ),
    r'server': LinkSchema(
      id: -5582821276758252914,
      name: r'server',
      target: r'ServerEntity',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _areaEntityGetId,
  getLinks: _areaEntityGetLinks,
  attach: _areaEntityAttach,
  version: '3.1.8',
);

int _areaEntityEstimateSize(
  AreaEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.background;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.haId.length * 3;
  {
    final value = object.image;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _areaEntitySerialize(
  AreaEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.background);
  writer.writeString(offsets[1], object.haId);
  writer.writeString(offsets[2], object.image);
  writer.writeString(offsets[3], object.name);
}

AreaEntity _areaEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AreaEntity(
    background: reader.readStringOrNull(offsets[0]),
    haId: reader.readString(offsets[1]),
    image: reader.readStringOrNull(offsets[2]),
    name: reader.readString(offsets[3]),
  );
  object.id = id;
  return object;
}

P _areaEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _areaEntityGetId(AreaEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _areaEntityGetLinks(AreaEntity object) {
  return [object.devices, object.server];
}

void _areaEntityAttach(IsarCollection<dynamic> col, Id id, AreaEntity object) {
  object.id = id;
  object.devices
      .attach(col, col.isar.collection<DeviceEntity>(), r'devices', id);
  object.server.attach(col, col.isar.collection<ServerEntity>(), r'server', id);
}

extension AreaEntityByIndex on IsarCollection<AreaEntity> {
  Future<AreaEntity?> getByHaId(String haId) {
    return getByIndex(r'haId', [haId]);
  }

  AreaEntity? getByHaIdSync(String haId) {
    return getByIndexSync(r'haId', [haId]);
  }

  Future<bool> deleteByHaId(String haId) {
    return deleteByIndex(r'haId', [haId]);
  }

  bool deleteByHaIdSync(String haId) {
    return deleteByIndexSync(r'haId', [haId]);
  }

  Future<List<AreaEntity?>> getAllByHaId(List<String> haIdValues) {
    final values = haIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'haId', values);
  }

  List<AreaEntity?> getAllByHaIdSync(List<String> haIdValues) {
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

  Future<Id> putByHaId(AreaEntity object) {
    return putByIndex(r'haId', object);
  }

  Id putByHaIdSync(AreaEntity object, {bool saveLinks = true}) {
    return putByIndexSync(r'haId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByHaId(List<AreaEntity> objects) {
    return putAllByIndex(r'haId', objects);
  }

  List<Id> putAllByHaIdSync(List<AreaEntity> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'haId', objects, saveLinks: saveLinks);
  }
}

extension AreaEntityQueryWhereSort
    on QueryBuilder<AreaEntity, AreaEntity, QWhere> {
  QueryBuilder<AreaEntity, AreaEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterWhere> anyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'name'),
      );
    });
  }
}

extension AreaEntityQueryWhere
    on QueryBuilder<AreaEntity, AreaEntity, QWhereClause> {
  QueryBuilder<AreaEntity, AreaEntity, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<AreaEntity, AreaEntity, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterWhereClause> idBetween(
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

  QueryBuilder<AreaEntity, AreaEntity, QAfterWhereClause> haIdEqualTo(
      String haId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'haId',
        value: [haId],
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterWhereClause> haIdNotEqualTo(
      String haId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'haId',
              lower: [],
              upper: [haId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'haId',
              lower: [haId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'haId',
              lower: [haId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'haId',
              lower: [],
              upper: [haId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterWhereClause> nameEqualTo(
      String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterWhereClause> nameNotEqualTo(
      String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterWhereClause> nameGreaterThan(
    String name, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [name],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterWhereClause> nameLessThan(
    String name, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [],
        upper: [name],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterWhereClause> nameBetween(
    String lowerName,
    String upperName, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [lowerName],
        includeLower: includeLower,
        upper: [upperName],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterWhereClause> nameStartsWith(
      String NamePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [NamePrefix],
        upper: ['$NamePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterWhereClause> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [''],
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterWhereClause> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'name',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'name',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'name',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'name',
              upper: [''],
            ));
      }
    });
  }
}

extension AreaEntityQueryFilter
    on QueryBuilder<AreaEntity, AreaEntity, QFilterCondition> {
  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition>
      backgroundIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'background',
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition>
      backgroundIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'background',
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> backgroundEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'background',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition>
      backgroundGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'background',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition>
      backgroundLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'background',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> backgroundBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'background',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition>
      backgroundStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'background',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition>
      backgroundEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'background',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition>
      backgroundContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'background',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> backgroundMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'background',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition>
      backgroundIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'background',
        value: '',
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition>
      backgroundIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'background',
        value: '',
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> haIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'haId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> haIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'haId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> haIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'haId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> haIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'haId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> haIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'haId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> haIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'haId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> haIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'haId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> haIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'haId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> haIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'haId',
        value: '',
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> haIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'haId',
        value: '',
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> idBetween(
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

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> imageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'image',
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> imageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'image',
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> imageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> imageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> imageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> imageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'image',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> imageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> imageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> imageContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> imageMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'image',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> imageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image',
        value: '',
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition>
      imageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'image',
        value: '',
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension AreaEntityQueryObject
    on QueryBuilder<AreaEntity, AreaEntity, QFilterCondition> {}

extension AreaEntityQueryLinks
    on QueryBuilder<AreaEntity, AreaEntity, QFilterCondition> {
  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> devices(
      FilterQuery<DeviceEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'devices');
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition>
      devicesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'devices', length, true, length, true);
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> devicesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'devices', 0, true, 0, true);
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition>
      devicesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'devices', 0, false, 999999, true);
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition>
      devicesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'devices', 0, true, length, include);
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition>
      devicesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'devices', length, include, 999999, true);
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition>
      devicesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'devices', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> server(
      FilterQuery<ServerEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'server');
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterFilterCondition> serverIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'server', 0, true, 0, true);
    });
  }
}

extension AreaEntityQuerySortBy
    on QueryBuilder<AreaEntity, AreaEntity, QSortBy> {
  QueryBuilder<AreaEntity, AreaEntity, QAfterSortBy> sortByBackground() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'background', Sort.asc);
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterSortBy> sortByBackgroundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'background', Sort.desc);
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterSortBy> sortByHaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'haId', Sort.asc);
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterSortBy> sortByHaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'haId', Sort.desc);
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterSortBy> sortByImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.asc);
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterSortBy> sortByImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.desc);
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension AreaEntityQuerySortThenBy
    on QueryBuilder<AreaEntity, AreaEntity, QSortThenBy> {
  QueryBuilder<AreaEntity, AreaEntity, QAfterSortBy> thenByBackground() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'background', Sort.asc);
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterSortBy> thenByBackgroundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'background', Sort.desc);
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterSortBy> thenByHaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'haId', Sort.asc);
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterSortBy> thenByHaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'haId', Sort.desc);
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterSortBy> thenByImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.asc);
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterSortBy> thenByImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.desc);
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension AreaEntityQueryWhereDistinct
    on QueryBuilder<AreaEntity, AreaEntity, QDistinct> {
  QueryBuilder<AreaEntity, AreaEntity, QDistinct> distinctByBackground(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'background', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QDistinct> distinctByHaId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'haId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QDistinct> distinctByImage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'image', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AreaEntity, AreaEntity, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension AreaEntityQueryProperty
    on QueryBuilder<AreaEntity, AreaEntity, QQueryProperty> {
  QueryBuilder<AreaEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AreaEntity, String?, QQueryOperations> backgroundProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'background');
    });
  }

  QueryBuilder<AreaEntity, String, QQueryOperations> haIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'haId');
    });
  }

  QueryBuilder<AreaEntity, String?, QQueryOperations> imageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'image');
    });
  }

  QueryBuilder<AreaEntity, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}
