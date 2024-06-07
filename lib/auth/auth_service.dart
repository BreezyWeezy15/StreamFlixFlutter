
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/utils.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../models/MovieModel.dart';
import '../models/cast/CastModel.dart';
import '../models/details/MovieDetails.dart';

class AuthService {

   Future<MovieModel?> getMovies(String movieCategory , String language , int page) async {
      var headers = <String,String>{};
      headers["Authorization"] = Utils.apiKey;
      headers["Accept"] = "application/json";
      var url = "${Utils.apiUrl}$movieCategory?language=$language&page=$page";
      HttpClientWithMiddleware httpClientWithMiddleware = HttpClientWithMiddleware.build(
         middlewares: [HttpLogger(logLevel: LogLevel.BODY)]
      );
      var response = await http.get(Uri.parse(url),headers: headers);
      if(response.statusCode == 200){
         var decodedResponse = jsonDecode(response.body);
         return MovieModel.fromJson(decodedResponse);
      } else {
         return null;
      }
   }
   Future<MovieDetails?> getMovieDetails(String movieID  , String language) async {
      var headers = <String,String>{};
      headers["Authorization"] = Utils.apiKey;
      headers["Accept"] = "application/json";
      var url = "${Utils.apiUrl}$movieID?language=$language";
      HttpClientWithMiddleware httpClientWithMiddleware = HttpClientWithMiddleware.build(
          middlewares: [HttpLogger(logLevel: LogLevel.BODY)]
      );
      var response = await http.get(Uri.parse(url),headers: headers);
      if(response.statusCode == 200){
         var decodedResponse = jsonDecode(response.body);
         return MovieDetails.fromJson(decodedResponse);
      } else {
         return null;
      }
   }
   Future<CastModel?> getCast(String movieID , String language) async {
      var url =  "${Utils.apiUrl}$movieID/credits?language=$language";
      var headers = <String,String>{};
      headers["Authorization"] = Utils.apiKey;
      headers["accept"] = "application/json";
      HttpClientWithMiddleware httpClientWithMiddleware = HttpClientWithMiddleware.build(
         middlewares: [HttpLogger(logLevel: LogLevel.BODY)]
      );
      var response = await http.get(Uri.parse(url),headers: headers);
      if(response.statusCode == 200){
         var decodedResponse = jsonDecode(response.body);
         return CastModel.fromJson(decodedResponse);
      } else {
         return null;
      }
   }

}