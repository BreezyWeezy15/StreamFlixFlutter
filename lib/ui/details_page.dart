import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:drift/drift.dart' as d;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:movie_app/business/database_controller.dart';
import 'package:movie_app/business/movie_controller.dart';
import 'package:movie_app/database/movie_database.dart';
import 'package:movie_app/fonts.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/models/Results.dart';
import 'package:movie_app/storage/storage_helper.dart';
import 'package:movie_app/utils.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late Results results;
  var iconPath = "assets/images/bookmark_unfilled.png";
  late DatabaseController databaseController;
  late MovieController movieController;

  @override
  void initState() {
    super.initState();
    movieController = Get.find<MovieController>();
    databaseController = Get.find<DatabaseController>();
    results = Get.arguments;
    ever(databaseController.data, (value){
        for (var element in value) {
          print("Results ${results.id} / ${element!.id}");
          if(results.id == element?.id.toInt()){
            setState(() {
              iconPath = "assets/images/bookmark_filled.png";
            });
          }
        }
    });
  }
  @override
  Widget build(BuildContext context) {

    movieController.getMovieDetails(results.id.toString(), "en-US");
    movieController.getMovieCast(results.id.toString(), "en-US");
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8),bottomRight: Radius.circular(8)),
                    child: Image.network("http://image.tmdb.org/t/p/w500/${results.posterPath!}",fit: BoxFit.cover,
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
                    Expanded(child: Text(results.title!,maxLines: 2,style: getPoppingBold().copyWith(fontSize: 35),)),
                    const SizedBox(width: 20,),
                    GestureDetector(
                      onTap: () async {
                        MovieHelperCompanion data = MovieHelperCompanion(
                          id: d.Value(results.id!.toInt()),
                          title: d.Value(results.title),
                          postPath: d.Value(results.posterPath),
                          releaseDate: d.Value(results.releaseDate),
                          rating: d.Value(Utils.getRating(results.voteAverage.toString())),
                          movieID: d.Value(results.id.toString())
                        );
                        var result = await database.saveMovie(data);
                        if(result != -1){
                          Fluttertoast.showToast(msg: "Movie Successfully Added To Favs");
                          setState(() {
                            iconPath = "assets/images/bookmark_filled.png";
                          });
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
                    Text(Utils.getRating(results.voteAverage.toString()),
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
                        Text(results.originalLanguage!,style: getPoppingBold().copyWith(fontSize: 20),)
                      ],
                    )),
                    Expanded(child:  Column(
                      children: [
                        Text("Release Date",style: getPoppingRegular().copyWith(fontSize: 17),),
                        const SizedBox(height: 10,),
                        Text(results.releaseDate!,style: getPoppingBold().copyWith(fontSize: 18),)
                      ],
                    )),
                    Expanded(child:  Column(
                      children: [
                        Text("Popularity",style: getPoppingRegular().copyWith(fontSize: 17),),
                        const SizedBox(height: 10,),
                        Text(results.popularity.toString(),style: getPoppingBold().copyWith(fontSize: 18),)
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
                    Text(results.overview!,style: getPoppingRegular().copyWith(fontSize: 16),)
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
                    return SizedBox(
                      height: 150,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: movieController.castModel.value?.cast?.length,
                        itemBuilder: (context,index){
                          var e = movieController.castModel.value?.cast?[index];
                          return  Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: SizedBox(
                              width: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network("http://image.tmdb.org/t/p/w500/${e?.profilePath!}",width: 100,height: 100,filterQuality: FilterQuality.high,
                                      fit: BoxFit.cover,),
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(e!.name!,style: getPoppingMedium().copyWith(fontSize: 15),
                                    maxLines: 2,overflow: TextOverflow.ellipsis,)
                                ],
                              ),
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
                    return SizedBox(
                      height: 100,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: movieController.movieDetails.value?.productionCompanies!.length,
                        itemBuilder: (context,index){
                          var e = movieController.movieDetails.value?.productionCompanies![index];
                          return  Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20),
                            child: Image.network("http://image.tmdb.org/t/p/w500/${e?.logoPath!}",width: 120,height: 120,filterQuality: FilterQuality.high,),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
