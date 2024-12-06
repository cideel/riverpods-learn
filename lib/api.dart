import 'dart:convert'; // For jsonDecode
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpods_learning/Model/movie.dart';
import 'package:riverpods_learning/movie_detail.dart';
import 'package:riverpods_learning/Model/movieDetail.dart';


class MovieService {
  final String apiKey = '865555cb95a15d1a832371c4e35230b4'; 

  Future<List<Movie>> fetchPopularMovies() async {
    final url =
        'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> moviesJson = data['results'];
      return moviesJson.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<MovieDetail> fetchMovieDetail(int movieId) async {
    final detailUrl = 'https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey';
    final creditUrl = 'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey';
    final reviewUrl = 'https://api.themoviedb.org/3/movie/$movieId/reviews?api_key=865555cb95a15d1a832371c4e35230b4';

    final detailResponse = await http.get(Uri.parse(detailUrl));
    if(detailResponse.statusCode != 200){
      throw Exception('failed to load movie detail');
    }

    final creditResponse = await http.get(Uri.parse(creditUrl));
    if(creditResponse.statusCode!=200){
      throw Exception('failed to load credit');
    }

    final reviewResponse = await http.get(Uri.parse(reviewUrl));
    if(reviewResponse.statusCode != 200){
      throw Exception("failed to load review");
    }
    final detailData =  jsonDecode(detailResponse.body);
    final creditsData = jsonDecode(creditResponse.body);
    final reviewData = jsonDecode(reviewResponse.body);

    return MovieDetail.fromJson(detailData, creditsData['cast']);
    
      

  }

  

  

}





final movieServiceProvider = Provider<MovieService>((ref) {
  return MovieService();
});

final movieListProvider = FutureProvider<List<Movie>>((ref) async {
  final movieService = ref.read(movieServiceProvider);
  return await movieService.fetchPopularMovies();
});

final movieDetailProvider = FutureProvider.family<MovieDetail, int>((ref, movieId) async {
  final movieService = ref.read(movieServiceProvider);
  return await movieService.fetchMovieDetail(movieId);
});