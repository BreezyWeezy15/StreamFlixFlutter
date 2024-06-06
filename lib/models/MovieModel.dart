import 'Dates.dart';
import 'Results.dart';

class MovieModel {
  MovieModel({
      this.dates, 
      this.page, 
      this.results, 
      this.totalPages, 
      this.totalResults,});

  MovieModel.fromJson(dynamic json) {
    dates = json['dates'] != null ? Dates.fromJson(json['dates']) : null;
    page = json['page'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
  Dates? dates;
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    final dates = this.dates;
    if (dates != null) {
      map['dates'] = dates.toJson();
    }
    map['page'] = page;
    final results = this.results;
    if (results != null) {
      map['results'] = results.map((v) => v.toJson()).toList();
    }
    map['total_pages'] = totalPages;
    map['total_results'] = totalResults;
    return map;
  }

}