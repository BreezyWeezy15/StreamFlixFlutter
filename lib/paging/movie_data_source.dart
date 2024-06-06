
import 'package:movie_app/auth/auth_service.dart';
import 'package:movie_app/models/MovieModel.dart';
import 'package:movie_app/models/Results.dart';
import 'package:super_paging/super_paging.dart';

class MovieDataSource extends PagingSource<int,Results> {
  late AuthService authService;
  late String movieCategory;
  late String language;
  late int page;
  MovieDataSource({required this.authService,required this.movieCategory,required this.language,
   required this.page});

  @override
  Future<LoadResult<int, Results>> load(LoadParams<int> params) async {
    try {
      var key  = params.key! + 1;
      final movies = await authService.getMovies(movieCategory, language, key);
      return LoadResult.page(nextKey: key, items: movies!.results!);
    } catch (e) {
      return LoadResult.error(e);
    }
  }


  
}