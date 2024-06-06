

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:movie_app/main.dart';

import '../database/movie_database.dart';

class DatabaseController extends GetxController {
   var data = Rx<List<MovieHelperData?>>([]);
   var error = "".obs;

   Future<int> saveMovie(MovieHelperCompanion movieHelperCompanion) async {
       return await databaseService.saveMovie(movieHelperCompanion);
   }
   void getAllMovies() {
     databaseService.getAllMovies().then((value){
       if(value.isNotEmpty){
          data.value = value;
          update();
       }
     });
   }
   Future<int> deleteMovie(int id) async {
     return await databaseService.deleteMovie(id);
   }
   Future<int> deleteAllMovies() async {
     return await databaseService.deleteAllMovies();
   }

}