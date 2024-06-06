import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:movie_app/business/database_controller.dart';
import 'package:movie_app/fonts.dart';
import 'package:movie_app/storage/storage_helper.dart';

import '../utils.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  late DatabaseController databaseController;

  @override
  void initState() {
    super.initState();
    databaseController  = Get.find<DatabaseController>();
    databaseController.getAllMovies();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(child: Text("Fav Movies",style: getPoppingBold().copyWith(fontSize: 20),)),
                  const SizedBox(width: 10,),
                  GestureDetector(
                    onTap: (){
                       showDialog(
                           context: context,
                           builder: (context){
                              return AlertDialog(
                                title: Text("Delete AlL Movies",style: getPoppingMedium(),),
                                content: Text("Are you sure you want to delete all movis?",style: getPoppingMedium(),),
                                actions: [
                                  ElevatedButton(onPressed: () async {
                                    var results = await databaseController.deleteAllMovies();
                                    if(results != -1){
                                      Fluttertoast.showToast(msg: "All Movies Successfully Deleted");
                                      databaseController.getAllMovies();
                                      Navigator.pop(context);
                                    }
                                  }, child: Text("Yes",style: getPoppingMedium(),)),
                                  ElevatedButton(onPressed: (){
                                    Navigator.pop(context);
                                  }, child: Text("No",style: getPoppingMedium(),))
                                ],
                              );
                           });
                    },
                    child: Image.asset("assets/images/delete.png",width: 20,height: 20,color:
                    StorageHelper.getMode() == "Light" ? Colors.black54 : Colors.white,),
                  )
                ],
              ),
            ),
            Expanded(
              child: Obx((){
                if(databaseController.data.value.isNotEmpty){
                  var e = databaseController.data.value;
                  return SizedBox(
                    height: 150,
                    child: ListView.builder(
                      itemCount: e.length,
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: (){
                              //Get.toNamed("/details",arguments: e);
                            },
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network("http://image.tmdb.org/t/p/w500/${e[index]?.postPath!}",width: 120,height: 120,
                                    fit: BoxFit.cover,filterQuality: FilterQuality.high,),
                                ),
                                Expanded(child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(e[index]!.title!,style: getPoppingBold().copyWith(fontSize: 20),),
                                      const SizedBox(height: 10,),
                                      Row(children: [
                                        Image.asset("assets/images/rating.png",width: 20,height: 20,),
                                        const SizedBox(width: 10,),
                                        Text(e[index]!.rating!,style: getPoppingMedium().copyWith(fontSize: 15),)
                                      ],),
                                      // ListView.builder(
                                      //   itemCount: item.genreIds!.length,
                                      //   itemBuilder: (context,index){
                                      //     getGenres(jsonString).map((e){
                                      //       if(e.id.toString() == item.genreIds![index].toString()){
                                      //         return Container(
                                      //           padding: const EdgeInsets.all(10),
                                      //           decoration: BoxDecoration(
                                      //             borderRadius: BorderRadius.circular(16),
                                      //             color: Colors.blueGrey
                                      //           ),
                                      //           child: Center(child: Text(getGenres(jsonString)[index].name),),
                                      //         );
                                      //       }
                                      //       else {
                                      //         return Container();
                                      //       }
                                      //     });
                                      //     return Container();
                                      //   },
                                      // )
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return  Center(child: Text("No Data Found",style: getPoppingMedium().copyWith(fontSize: 25)));
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
