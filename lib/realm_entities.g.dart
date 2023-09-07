// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_entities.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class RealmSampleObject extends _RealmSampleObject
    with RealmEntity, RealmObjectBase, RealmObject {
  RealmSampleObject(
    String id,
    String name,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  RealmSampleObject._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<RealmSampleObject>> get changes =>
      RealmObjectBase.getChanges<RealmSampleObject>(this);

  @override
  RealmSampleObject freeze() =>
      RealmObjectBase.freezeObject<RealmSampleObject>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(RealmSampleObject._);
    return const SchemaObject(
        ObjectType.realmObject, RealmSampleObject, 'RealmSampleObject', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }
}

class RealmSampleObject2 extends _RealmSampleObject2
    with RealmEntity, RealmObjectBase, RealmObject {
  RealmSampleObject2(
    String id,
    String name,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  RealmSampleObject2._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<RealmSampleObject2>> get changes =>
      RealmObjectBase.getChanges<RealmSampleObject2>(this);

  @override
  RealmSampleObject2 freeze() =>
      RealmObjectBase.freezeObject<RealmSampleObject2>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(RealmSampleObject2._);
    return const SchemaObject(
        ObjectType.realmObject, RealmSampleObject2, 'RealmSampleObject2', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }
}
