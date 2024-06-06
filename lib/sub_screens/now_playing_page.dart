import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/auth/auth_service.dart';
import 'package:movie_app/business/movie_controller.dart';
import 'package:movie_app/fonts.dart';
import 'package:movie_app/paging/movie_data_source.dart';
import 'package:movie_app/utils.dart';
import 'package:super_paging/super_paging.dart';

import '../storage/storage_helper.dart';

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage({super.key});

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  late MovieController movieController;
  @override
  void initState() {
    super.initState();
    movieController = Get.find();
  }
  @override
  Widget build(BuildContext context) {
    final pager = Pager(
      initialKey: 1,
      config: const PagingConfig(pageSize: 20, initialLoadSize: 60),
      pagingSourceFactory: () => MovieDataSource(authService: movieController.authService, movieCategory: "now_playing",
          language: StorageHelper.getISO(), page: 1),
    );
    return Padding(
      padding: const EdgeInsets.all(10),
      child: PagingListView(
          scrollDirection: Axis.vertical,
          pager: pager,
          itemBuilder: (context,index){
            var item = pager.items.elementAt(index);
            return SizedBox(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: (){
                    Get.toNamed("/details",arguments: item);
                  },
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network("http://image.tmdb.org/t/p/w500/${item.backdropPath!}",width: 120,height: 120,
                          fit: BoxFit.cover,filterQuality: FilterQuality.high,),
                      ),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(item.title!,style: getPoppingBold().copyWith(fontSize: 20),),
                            const SizedBox(height: 10,),
                            Row(children: [
                              Image.asset("assets/images/rating.png",width: 20,height: 20,),
                              const SizedBox(width: 10,),
                              Text(Utils.getRating(item.voteAverage.toString()))
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
              ),
            );
          },
          emptyBuilder: (context){
            return const Center(child: Text("No results found"),);
          },
          errorBuilder: (context,error){
            return  Center(child: Text("Error $error"),);
          },
          loadingBuilder: (context){
            return const Center(child: CircularProgressIndicator(color: Colors.amber,));
          }),
    );
  }
}
