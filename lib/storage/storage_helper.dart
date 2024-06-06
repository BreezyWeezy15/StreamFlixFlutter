

import 'package:get_storage/get_storage.dart';

class StorageHelper {
   static final box = GetStorage();
   static setISO(String value){
      box.write("ISO", value);
   }
   static String getISO() {
      return box.read("ISO") ?? "en-US";
   }
   static setCode(int position){
      box.write("language", position);
   }
   static int getCode(){
       return box.read("language") ?? 0;
   }
   static setMode(String value){
      box.write("mode", value);
   }
   static String getMode(){
     return box.read("mode") ?? "Light";
   }
}