

import 'package:movie_app/main.dart';

import '../database/movie_database.dart';

class DatabaseService {

  Future<List<MovieHelperData?>> getAllMovies() async {
    return await database.getAllMovies();
  }

  Future<int> saveMovie(MovieHelperCompanion companion) async {
    return await database.saveMovie(companion);
  }

  Future<int> deleteMovie(int id) async {
    return await database.deleteMovie(id);
  }

  Future<int> deleteAllMovies() async {
    return await database.deleteAllMovies();
  }

}