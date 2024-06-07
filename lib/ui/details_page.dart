import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:drift/drift.dart' as d;
import 'package:movie_app/business/database_controller.dart';
import 'package:movie_app/business/movie_controller.dart';
import 'package:movie_app/database/movie_database.dart';
import 'package:movie_app/fonts.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/storage/storage_helper.dart';
import 'package:movie_app/utils.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var isAdded = false;
  late int movieID;
  var iconPath = "assets/images/bookmark_unfilled.png";
  late DatabaseController databaseController;
  late MovieController movieController;

  @override
  void initState() {
    super.initState();
    movieController = Get.find<MovieController>();
    databaseController = Get.find<DatabaseController>();
    movieID = Get.arguments;
    isMovieAdded();
    movieController.getMovieDetails(movieID.toString(), StorageHelper.getISO());
    movieController.getMovieCast(movieID.toString(), StorageHelper.getISO());

  }

  void isMovieAdded() {
     for (var element in databaseController.data) {
       if (movieID == element?.id.toInt()) {
         if (mounted) {
           setState(() {
             iconPath = "assets/images/bookmark_filled.png";
             isAdded = true;
           });
         }
       }
     }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Obx((){
            if(movieController.movieDetails.value != null){
              var data = movieController.movieDetails.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8),bottomRight: Radius.circular(8)),
                        child: Image.network("http://image.tmdb.org/t/p/w500/${data?.posterPath!}",fit: BoxFit.cover,
                          width: double.maxFinite,height: 300,),
                      ),
                      Positioned(
                        top: 20,
                        left: 20,
                        child: GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: Image.asset("assets/images/arrow.png",width: 30,height: 30,color: Colors.white,),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 20,top: 10),
                    child: Row(
                      children: [
                        Expanded(child: Text(data!.title!,maxLines: 2,style: getPoppingBold().copyWith(fontSize: 35),)),
                        const SizedBox(width: 20,),
                        GestureDetector(
                          onTap: () async {
                            if(isAdded){
                              try {
                                await databaseController.deleteMovie(data.id!.toInt());
                                Fluttertoast.showToast(msg: "Movie Successfully Removed From Favs");
                                setState(() {
                                  isAdded = false;
                                  iconPath = "assets/images/bookmark_unfilled.png";
                                });
                              } catch(e){
                                print("Erro deleting movie");
                              }

                            }
                            else {
                              try {
                                MovieHelperCompanion movieCompanion = MovieHelperCompanion(
                                    id: d.Value(data.id!.toInt()),
                                    title: d.Value(data.title),
                                    postPath: d.Value(data.posterPath),
                                    releaseDate: d.Value(data.releaseDate),
                                    rating: d.Value(Utils.getRating(data.voteAverage.toString())),
                                    movieID: d.Value(data.id.toString())
                                );
                                var result = await database.saveMovie(movieCompanion);
                                if(result != -1){
                                  Fluttertoast.showToast(msg: "Movie Successfully Added To Favs");
                                  setState(() {
                                    isAdded = true;
                                    iconPath = "assets/images/bookmark_filled.png";
                                  });
                                }
                              } catch(e){
                                print("error adding value $e");
                              }
                            }
                          },
                          child: Image.asset(iconPath,width: 25,height: 25,
                            color: StorageHelper.getMode() == "Light" ? Colors.black54 : Colors.white,),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 20,top: 10),
                    child: Row(
                      children: [
                        Image.asset("assets/images/rating.png",width: 20,height: 20,),
                        const SizedBox(width: 10,),
                        Text(Utils.getRating(data.voteAverage.toString()),
                          style: getPoppingRegular().copyWith(fontSize: 17),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        Expanded(child:  Column(
                          children: [
                            Text("Language",style: getPoppingRegular().copyWith(fontSize: 17),),
                            const SizedBox(height: 10,),
                            Text(data!.originalLanguage!,style: getPoppingBold().copyWith(fontSize: 20),)
                          ],
                        )),
                        Expanded(child:  Column(
                          children: [
                            Text("Release Date",style: getPoppingRegular().copyWith(fontSize: 17),),
                            const SizedBox(height: 10,),
                            Text(data.releaseDate!,style: getPoppingBold().copyWith(fontSize: 18),)
                          ],
                        )),
                        Expanded(child:  Column(
                          children: [
                            Text("Popularity",style: getPoppingRegular().copyWith(fontSize: 17),),
                            const SizedBox(height: 10,),
                            Text(data.popularity.toString(),style: getPoppingBold().copyWith(fontSize: 18),)
                          ],
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 10,top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Overview",style: getPoppingBold().copyWith(fontSize: 20),),
                        const SizedBox(height: 10,),
                        Text(data.overview!,style: getPoppingRegular().copyWith(fontSize: 16),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 10,top: 40),
                    child: Text("Cast",style: getPoppingBold().copyWith(fontSize: 20),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 20,top: 20),
                    child: Obx((){
                      if(movieController.castModel.value != null){
                        var data = movieController.castModel.value;
                        return SizedBox(
                          height: 150,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: data?.cast?.length,
                            itemBuilder: (context,index){
                              var e = data?.cast?[index];
                              return  Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SizedBox(
                                    width: 100,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        e?.profilePath != null ? ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Image.network("http://image.tmdb.org/t/p/w500/${e?.profilePath!}",width: 100,height: 100,filterQuality: FilterQuality.high,
                                            fit: BoxFit.cover,),
                                        ) : ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Image.asset("assets/images/logo.png",width: 100,height: 100,filterQuality: FilterQuality.high,
                                            fit: BoxFit.cover,),
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(e!.name!,style: getPoppingMedium().copyWith(fontSize: 15),
                                          maxLines: 2,overflow: TextOverflow.ellipsis,)
                                      ],
                                    )
                                ),
                              );
                            },
                          ),
                        );
                      }
                      else if(movieController.error.value != null){
                        return Center(child: Text(movieController.error.value!),);
                      }
                      else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 10,top: 30),
                    child: Text("Production Companies",style: getPoppingBold().copyWith(fontSize: 20),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 20,bottom: 20,top: 10),
                    child: Obx((){
                      if(movieController.movieDetails.value != null){
                        var data = movieController.movieDetails.value;
                        return SizedBox(
                          height: 100,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: data?.productionCompanies!.length,
                            itemBuilder: (context,index){
                              var e = data?.productionCompanies?[index];
                              return  Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20),
                                child: e?.logoPath != null ? Image.network("http://image.tmdb.org/t/p/w500/${e?.logoPath}",width: 120,height: 120,filterQuality: FilterQuality.high,) :
                                Container(),
                              );
                            },
                          ),
                        );
                      }
                      else {
                        return  SizedBox(
                          width: double.maxFinite,
                          height: 100,
                          child: Center(
                            child: Text("No Production Companies",style: getPoppingBold().copyWith(fontSize: 20,
                            color: StorageHelper.getMode() == "Light" ? Colors.black54  : Colors.white)),
                          ));
                      }
                    }),
                  )
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
        ),
      ),
    );
  }
}
