

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/storage/storage_helper.dart';

class ThemeController extends GetxController {
    var isLightTheme = StorageHelper.getMode();
    ThemeData get theme => isLightTheme == "Light" ? ThemeData.light() : ThemeData.dark();
}