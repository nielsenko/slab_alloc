import 'dart:async';
import 'dart:isolate';
import 'dart:developer' as dev;
import 'package:realm/realm.dart';
import 'package:path/path.dart' as path;
import 'realm_entities.dart';

class RealmDatabase {
  static Configuration get _mainConfig {
    final configuration = Configuration.local(
      [
        RealmSampleObject.schema,
        RealmSampleObject2.schema,
      ],
      schemaVersion: 0,
      path: path.join(Configuration.defaultStoragePath, "Realm-data.realm"),
      shouldDeleteIfMigrationNeeded: false,
    );
    print("Opening realm database located at: ${configuration.path}");
    return configuration;
  }

  final realm = Realm(_mainConfig);

  static Future<T> useNewInstance<T>(
      final Future<T> Function(Realm realm) block) async {
    return await Isolate.run(() async {
      final realm = RealmDatabase().realm;
      try {
        return await block.call(realm);
      } catch (error, stack) {
        dev.log("useNewInstance failed", error: error, stackTrace: stack);
        rethrow;
      } finally {
        realm.close();
      }
    });
  }
}
