import 'dart:ui';

import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';


// Popping Font Bold
TextStyle getPoppingBold(){
  return GoogleFonts.poppins(
      fontWeight : FontWeight.bold
  );
}
// Popping Font Medium
TextStyle getPoppingMedium(){
  return GoogleFonts.poppins(
      fontWeight : FontWeight.w500
  );
}
// Popping Font Regular
TextStyle getPoppingRegular(){
  return GoogleFonts.poppins(
      fontWeight : FontWeight.w300
  );
}