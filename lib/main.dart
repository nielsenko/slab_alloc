import 'dart:developer';

import 'package:flutter/material.dart';
import 'realm_db.dart';
import 'realm_entities.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

const ID_PREFIX = "PREFIX_";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var isLoading = false;
  final oneMillion = 1000000;

  final realmDb = RealmDatabase();

  Future<void> _insertLargeData() async {
    setState(() {
      isLoading = true;
    });
    try {
      await RealmDatabase.useNewInstance((realm) async {
        await realm.writeAsync(() async {
          realm.addAll(
            [
              RealmSampleObject(
                  "${ID_PREFIX}RealmSampleObject 1", "Sample object 1"),
              RealmSampleObject(
                  "${ID_PREFIX}RealmSampleObject 2", "Sample object 2"),
            ],
            update: true,
          );
        });
        for (var i = 0; i < 100; i++) {
          final items = List.generate(10000, (index) {
            final id = const Uuid().v4().split("-").first;
            return RealmSampleObject2("$ID_PREFIX$id", "Object n $i");
          });
          await realm.writeAsync(() async {
            print("Adding ${items.length} items to realm");
            realm.addAll(items, update: true);
          });
        }
      });
    } catch (error, stack) {
      log("Failed to insert: ", error: error, stackTrace: stack);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    print("Done");
  }

  Future<void> _deleteAllData() async {
    try {
      setState(() {
        isLoading = true;
      });
      await RealmDatabase.useNewInstance((realm) async {
        await realm.writeAsync(() async {
          realm.deleteMany(
            realm.query<RealmSampleObject>(r"id BEGINSWITH $0", [ID_PREFIX]),
          );
          realm.deleteMany(
            realm.query<RealmSampleObject2>(r"id BEGINSWITH $0", [ID_PREFIX]),
          );
        });
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  late final objectCount1 = realmDb.realm
      .query<RealmSampleObject>("TRUEPREDICATE")
      .changes
      .map((event) => event.results.length);

  late final objectCount2 = realmDb.realm
      .query<RealmSampleObject2>("TRUEPREDICATE")
      .changes
      .map((event) => event.results.length);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          direction: Axis.vertical,
          spacing: 32,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            StreamBuilder(
              stream: objectCount1,
              builder: (_, snapshot) => Text(
                  "RealmSampleObject1 count: ${snapshot.data ?? 'unknown'}"),
            ),
            StreamBuilder(
              stream: objectCount2,
              builder: (_, snapshot) => Text(
                  "RealmSampleObject2 count: ${snapshot.data ?? 'unknown'}"),
            ),
            ElevatedButton(
              child: Text("Insert large data !"),
              onPressed: () {
                _insertLargeData();
              },
            ),
            ElevatedButton(
              child: Text("Delete all data"),
              onPressed: () {
                _deleteAllData();
              },
            ),
          ],
        ),
      ),
    );
  }
}
