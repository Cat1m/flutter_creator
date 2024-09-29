import 'package:sample_flutter/data/network/network.dart';
import 'package:sample_flutter/model/movie_list/movie_list_model.dart';
import 'package:sample_flutter/repository/movies_api/movies_api_repository.dart';
import 'package:sample_flutter/utils/extensions/app_url.dart';

class MoviesHttpApiRepository implements MoviesApiRepository {
  final _apiServices = NetworkApiService();

  @override
  Future<MovieListModel> fetchMoviesList() async {
    final response =
        await _apiServices.getApi(AppUrl.popularMoviesListEndPoint);
    return MovieListModel.fromJson(response);
  }
}
