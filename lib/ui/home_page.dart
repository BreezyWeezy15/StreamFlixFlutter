import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/business/database_controller.dart';
import 'package:movie_app/business/movie_controller.dart';
import 'package:movie_app/fonts.dart';
import 'package:movie_app/storage/storage_helper.dart';
import 'package:movie_app/sub_screens/now_playing_page.dart';
import 'package:movie_app/sub_screens/popular_page.dart';
import 'package:movie_app/sub_screens/rated_page.dart';
import 'package:movie_app/sub_screens/upcoming_page.dart';
import 'package:movie_app/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DatabaseController databaseController;
  late MovieController movieController;
  int index = 0;
  final List<Widget> _widgets = [
    const NowPlayingPage(),
    const PopularPage(),
    const TopRatedPage(),
    const UpcomingPage()
  ];
  final List<String> _types = ["Now Playing","Popular","Top Rated","Upcoming"];
  @override
  void initState() {
    super.initState();
    movieController = Get.put(MovieController());
    databaseController = Get.put(DatabaseController());
    movieController.getMovies("now_playing", StorageHelper.getISO(), 1);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
           showSelectedLabels: false,
           showUnselectedLabels: false,
           currentIndex: index,
           onTap: (dex){
             setState(() {
               index = dex;
             });
           },
           type: BottomNavigationBarType.fixed,
           items: [
              BottomNavigationBarItem(icon: Image.asset("assets/images/now.png", width: 25,height: 25,
              color: StorageHelper.getMode() == "Light" ? Colors.black54 : Colors.white,),label: ''),
              BottomNavigationBarItem(icon: Image.asset("assets/images/popular.png",width: 25,height: 25,
                color: StorageHelper.getMode() == "Light" ? Colors.black54 : Colors.white,),label: ''),
              BottomNavigationBarItem(icon: Image.asset("assets/images/rated.png",width: 25,height: 25,
                color: StorageHelper.getMode() == "Light" ? Colors.black54 : Colors.white,),label: ''),
              BottomNavigationBarItem(icon: Image.asset("assets/images/upcoming.png",width: 25,height: 25,
                color: StorageHelper.getMode() == "Light" ? Colors.black54 : Colors.white,),label: '')
           ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
               padding: const EdgeInsets.all(15),
               child: Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Expanded(child: Text("Stream Flix",style: getPoppingBold().copyWith(fontSize: 20))),
                   GestureDetector(
                     onTap: (){
                       Get.toNamed("/fav");
                     },
                     child: Image.asset("assets/images/bookmark_filled.png",width: 20,height: 20,
                       color: StorageHelper.getMode() == "Light" ? Colors.black54 : Colors.white,),
                   ),
                   const SizedBox(width: 15,),
                   GestureDetector(
                     onTap: (){
                       Get.toNamed("/settings");
                     },
                     child: Image.asset("assets/images/settings.png",width: 20,height: 20,
                       color: StorageHelper.getMode() == "Light" ? Colors.black54 : Colors.white,),
                   )
                 ],
               ),
             ),
             Padding(
               padding: const EdgeInsets.only(top: 10,left: 15,right: 15),
               child: Text("Now Showing",style: getPoppingBold().copyWith(fontSize: 25)),
             ),
             Obx((){
                var data = movieController.movieData.value;
                if(data != null){
                  return Container(
                    height: 230,
                    margin: const EdgeInsets.all(10),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: data.results?.length,
                      itemBuilder: (context,index){
                        var e = data.results?[index];
                        return  SizedBox(
                          height: 180,
                          width: 150,
                          child: GestureDetector(
                            onTap: (){
                              Get.toNamed("/details",arguments: e);
                            },
                            child: Card(
                              margin: const EdgeInsets.all(5),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network("http://image.tmdb.org/t/p/w500/${e?.backdropPath!}",
                                      filterQuality: FilterQuality.high,fit: BoxFit.cover,height: 150,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(e!.title!,style: getPoppingBold().copyWith(fontSize: 18),maxLines: 1,
                                      overflow: TextOverflow.ellipsis,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        Image.asset("assets/images/rating.png",height: 15,width: 15,filterQuality: FilterQuality.high,),
                                        const SizedBox(width: 5,),
                                        Expanded(child: Text(Utils.getRating(e.voteAverage.toString()),style: getPoppingMedium(),))
                                      ],
                                    ),
                                  )
                                ],
                              ),
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
             Padding(
               padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
               child: Text(_types[index],style: getPoppingBold().copyWith(fontSize: 25),),
             ),
             Expanded(
               child: _widgets[index],
             )
          ],
        ),
      ),
    );
  }
}
