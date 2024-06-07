import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:super_paging/super_paging.dart';

import '../business/movie_controller.dart';
import '../fonts.dart';
import '../paging/movie_data_source.dart';
import '../storage/storage_helper.dart';
import '../utils.dart';

class PopularPage extends StatefulWidget {
  const PopularPage({super.key});

  @override
  State<PopularPage> createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage> {
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
      pagingSourceFactory: () => MovieDataSource(authService: movieController.authService, movieCategory: "popular",
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
                    Get.toNamed(Utils.detailsRoute,arguments: item?.id);
                  },
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: item?.posterPath != null ?
                        Image.network("http://image.tmdb.org/t/p/w500/${item?.backdropPath}",width: 120,height: 120,
                          fit: BoxFit.cover,filterQuality: FilterQuality.high,) :
                        Image.asset("assets/images/no_image.png",width: 120,height: 120,
                          fit: BoxFit.cover,filterQuality: FilterQuality.high,color: StorageHelper.getMode()
                              == "Light" ? Colors.black54 : Colors.white,),
                      ),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(item?.title != null ? item!.title! : "N/A",style: getPoppingBold().copyWith(fontSize: 20),maxLines: 2,),
                            const SizedBox(height: 10,),
                            Row(children: [
                              Image.asset("assets/images/rating.png",width: 20,height: 20,),
                              const SizedBox(width: 10,),
                              Text(Utils.getRating(item?.voteAverage != null ? item!.voteAverage.toString() : "0.0"))
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
