import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movie_app/auth/database_service.dart';
import 'package:movie_app/database/movie_database.dart';
import 'package:movie_app/ui/splash_page.dart';
import 'package:movie_app/utils.dart';
import 'business/theme_controller.dart';

DatabaseService databaseService = DatabaseService();
MyDatabase database = MyDatabase();
void main() async {
  await GetStorage.init();
  final ThemeController themeController = Get.put(ThemeController());
  runApp(GetMaterialApp(
    home: const MyApp(),
    debugShowCheckedModeBanner: false,
    theme: themeController.theme,
    getPages: getPages,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const SplashPage();
  }
}
