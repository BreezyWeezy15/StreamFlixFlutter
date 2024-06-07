import 'package:get/get.dart';
import 'package:movie_app/main.dart';
import '../database/movie_database.dart';

class DatabaseController extends GetxController {
   RxList<MovieHelperData?> data = RxList([]);
   var error = "".obs;

   Future<int> saveMovie(MovieHelperCompanion movieHelperCompanion) async {
       return await databaseService.saveMovie(movieHelperCompanion);
   }
   void getAllMovies() {
     data.clear();
     databaseService.getAllMovies().then((value){
       if(value.isNotEmpty){
          data.value = value;
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