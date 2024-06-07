
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:movie_app/business/database_controller.dart';
import 'package:movie_app/fonts.dart';
import 'package:movie_app/storage/storage_helper.dart';

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
    databaseController = Get.find<DatabaseController>();
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
                                content: Text("Are you sure you want to delete all movies?",style: getPoppingMedium(),),
                                actions: [
                                  ElevatedButton(onPressed: () async {
                                    try {
                                      await databaseController.deleteAllMovies();
                                      databaseController.getAllMovies();
                                      Fluttertoast.showToast(msg: "All Movies Successfully Deleted");
                                      Navigator.pop(context);
                                    } catch(e){
                                      print("error deleting all item $e");
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
                if(databaseController.data.isNotEmpty){
                  var e = databaseController.data;
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
                            child: Dismissible(
                              key: Key(UniqueKey().toString()),
                              direction: DismissDirection.startToEnd,
                              onDismissed: (direction) async {
                                if(direction == DismissDirection.startToEnd){
                                  var result = await databaseController.deleteMovie(e[index]!.id);
                                  if(result != -1){
                                    databaseController.getAllMovies();
                                    Fluttertoast.showToast(msg: "Movie Successfully Removed");
                                  }
                                }
                              },
                              confirmDismiss: (direction) async {
                                if(direction == DismissDirection.startToEnd){

                                  return true;
                                }
                                return false;
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
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                else {
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
