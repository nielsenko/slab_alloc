import 'package:realm/realm.dart';

part 'realm_entities.g.dart';

@RealmModel(ObjectType.realmObject)
class _RealmSampleObject {
  @PrimaryKey()
  late String id;
  late String name;
}

@RealmModel(ObjectType.realmObject)
class _RealmSampleObject2 {
  @PrimaryKey()
  late String id;
  late String name;
}
