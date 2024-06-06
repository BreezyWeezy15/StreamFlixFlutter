import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'movie_database.g.dart';

@DriftDatabase(include: {'movie_helper.drift'},)
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
  Future<List<MovieHelperData>> getAllMovies() async {
    return await select(movieHelper).get();
  }

  Future<int> saveMovie(MovieHelperCompanion companion) async {
    return await into(movieHelper).insert(companion);
  }

  Future<int> deleteMovie(int id) async {
    return (delete(movieHelper)..where((val) => movieHelper.id.equals(id))).go();
  }

  Future<int> deleteAllMovies() async {
    return await delete(movieHelper).go();
  }

  Future<int> updateMovie(MovieHelperCompanion companion) async {
    return await update(movieHelper).write(MovieHelperCompanion(id: companion.id,));
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'memorysaver.db'));
    return NativeDatabase(file);
  });
}