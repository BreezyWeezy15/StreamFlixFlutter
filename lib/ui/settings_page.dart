
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:movie_app/business/movie_controller.dart';
import 'package:movie_app/fonts.dart';
import 'package:movie_app/storage/storage_helper.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
   var isToggled = false;
   var mode = "Light";
   late MovieController movieController;
   final List<String> _languages  = ["English","French","Spanish","Italian"];
   final List<String> _values = ["en-US","fr-FR","es-SP","it-IT"];
   int selectedRadio = 0;

   @override
  void initState() {
    super.initState();
    movieController = Get.put(MovieController());
    setState(() {
      selectedRadio = StorageHelper.getCode();
      isToggled = StorageHelper.getMode() == "Light" ? false : true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        movieController.getMovies("now_playing", StorageHelper.getISO(), 1);
                        Get.back();
                      },
                      child: Image.asset("assets/images/arrow.png",height: 20,width: 20,
                        color: StorageHelper.getMode() == "Light" ? Colors.black54 : Colors.white,),
                    ),
                    const SizedBox(width: 10,),
                    Text("Settings",style: getPoppingBold().copyWith(fontSize: 25),)
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Change Language",style: getPoppingMedium().copyWith(fontSize: 18),),
                        Text(_languages[selectedRadio],style: getPoppingMedium().copyWith(fontSize: 18),)
                      ],
                    )),
                    GestureDetector(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              content: StatefulBuilder(
                                builder: (context,state){
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 200,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: List<Widget>.generate(_languages.length, (index){
                                        return Row(
                                          children: [
                                            Expanded(child: Text(_languages[index],style: getPoppingMedium().copyWith(fontSize: 18),)),
                                            const SizedBox(width: 10,),
                                            Radio<int>(
                                                value: index,
                                                groupValue: selectedRadio,
                                                onChanged: (index){
                                                  setState(() => selectedRadio = index!);
                                                  StorageHelper.setISO(_values[selectedRadio]);
                                                  StorageHelper.setCode(selectedRadio);
                                                  Navigator.pop(context);
                                                })
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        );
                      },
                      child: Image.asset("assets/images/plus.png",width: 25,height: 25,
                      color: StorageHelper.getMode() == "Light" ? Colors.black54 : Colors.white,),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Divider(color: StorageHelper.getMode() == "Light" ? Colors.black54 : Colors.white,),
              ),
              Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Current Mode",style: getPoppingMedium().copyWith(fontSize: 20),),
                      Text(mode,style: getPoppingMedium().copyWith(fontSize: 20),)
                    ],
                  )),
                  Switch(
                      value: isToggled,
                      onChanged: (value){
                        setState(() {
                          isToggled = value;
                          if(isToggled){
                             mode = "Dark";
                             Get.changeThemeMode(ThemeMode.dark);
                          } else {
                             Get.changeThemeMode(ThemeMode.light);
                             mode = "Light";
                          }
                          StorageHelper.setMode(mode);
                        });
                      })
                ],
              ),
            ),
               Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Divider(color: StorageHelper.getMode() == "Light" ? Colors.black54 : Colors.white,),
            ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(child: Text("Version",style: getPoppingMedium().copyWith(fontSize: 20),)),
                    Text("V1.0",style: getPoppingBold().copyWith(fontSize: 20),)
                  ],
                ),
              ),


          ],
        ),
      ),
    );
  }
}
