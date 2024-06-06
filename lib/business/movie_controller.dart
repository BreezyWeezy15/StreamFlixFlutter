

import 'package:get/get.dart';
import 'package:movie_app/auth/auth_service.dart';
import 'package:movie_app/models/MovieModel.dart';
import 'package:movie_app/models/cast/CastModel.dart';
import 'package:movie_app/models/details/MovieDetails.dart';

class MovieController extends GetxController {
    AuthService authService = AuthService();
    Rx<MovieModel?> movieData = MovieModel().obs;
    Rx<MovieDetails?> movieDetails = MovieDetails().obs;
    Rx<CastModel?> castModel = CastModel().obs;
    Rx<String?> error = null.obs;

    void getMovies(String category , String language , int page)  {
      authService.getMovies(category, language, page).then((value){
        if(value != null){
          movieData.value = value;
          error.value = null;
        } else {
          error.value = "Could not fetch movies";
        }
      });
    }
    void getMovieDetails(String movieID , String language)  {
      authService.getMovieDetails(movieID,language).then((value){
        if(value != null){
          movieDetails.value = value;
          error.value = null;
        } else {
          error.value = "Could not fetch movies";
        }
      });
    }
    void getMovieCast(String movieID , String language){
       authService.getCast(movieID, language).then((value){
          if(value != null){
            castModel.value = value;
          } else {
            error.value = "No cast found";
          }
       });
    }
}