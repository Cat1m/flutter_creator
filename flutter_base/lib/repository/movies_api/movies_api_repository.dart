import 'package:sample_flutter/model/movie_list/movie_list_model.dart';

abstract class MoviesApiRepository {
  Future<MovieListModel> fetchMoviesList();
}
