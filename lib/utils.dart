

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:movie_app/ui/details_page.dart';
import 'package:movie_app/ui/fav_screen.dart';
import 'package:movie_app/ui/home_page.dart';
import 'package:movie_app/ui/settings_page.dart';
import 'package:movie_app/ui/splash_page.dart';

import 'models/genre_model.dart';

class Utils {
   static const  String apiKey = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiYmZkYTMxMGI1MTdkYWVlZWM2MWUzNDkzYWI1ZWZkOCIsInN1YiI6IjVkMzA5NmVjNTExZDA5MGY0YjU3OTQ4YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.x1NIb12Qei1ok47xYiLE2syJmXuvoicqgKbFrQrSMZ4";
   static const String apiUrl = "https://api.themoviedb.org/3/movie/";

   static String getRating(String rating) {
     if (rating.contains(".")) {
       return "${rating.substring(0,rating.indexOf("."))}/10 IMDb";
     }
     return rating;
   }
}
List<GetPage> getPages = [
  GetPage(name: "/splash", page: () => const SplashPage()),
  GetPage(name: "/home", page: () => const HomePage()),
  GetPage(name: "/details", page: () => const DetailsPage()),
  GetPage(name: "/settings", page: () => const SettingsPage()),
  GetPage(name: "/fav", page: () => const FavPage())
];

const String jsonString = '''
  {
    "genres": [
      {"id": 28, "name": "Action"},
      {"id": 12, "name": "Adventure"},
      {"id": 16, "name": "Animation"},
      {"id": 35, "name": "Comedy"},
      {"id": 80, "name": "Crime"},
      {"id": 99, "name": "Documentary"},
      {"id": 18, "name": "Drama"},
      {"id": 10751, "name": "Family"},
      {"id": 14, "name": "Fantasy"},
      {"id": 36, "name": "History"},
      {"id": 27, "name": "Horror"},
      {"id": 10402, "name": "Music"},
      {"id": 9648, "name": "Mystery"},
      {"id": 10749, "name": "Romance"},
      {"id": 878, "name": "Science Fiction"},
      {"id": 10770, "name": "TV Movie"},
      {"id": 53, "name": "Thriller"},
      {"id": 10752, "name": "War"},
      {"id": 37, "name": "Western"}
    ]
  }
  ''';
List<Genre> getGenres(String jsonString) {
  final Map<String, dynamic> decoded = json.decode(jsonString);
  final List<dynamic> genresJson = decoded['genres'];
  return genresJson.map((json) => Genre.fromJson(json)).toList();
}

