import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:super_paging/super_paging.dart';

import '../business/movie_controller.dart';
import '../fonts.dart';
import '../paging/movie_data_source.dart';
import '../storage/storage_helper.dart';
import '../utils.dart';

class UpcomingPage extends StatefulWidget {
  const UpcomingPage({super.key});

  @override
  State<UpcomingPage> createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage> {
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
      pagingSourceFactory: () => MovieDataSource(authService: movieController.authService, movieCategory: "upcoming",
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
                            Text(item.title!,style: getPoppingBold().copyWith(fontSize: 25),maxLines: 2,),
                            Row(children: [
                              Image.asset("assets/images/rating.png",width: 25,height: 25,),
                              const SizedBox(width: 10,),
                              Text(Utils.getRating(item.voteAverage.toString()))
                            ],)
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
