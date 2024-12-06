class Movie {
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final double rating;
  final String backpath;
  final String language;
  final double popularity;
  final int id;


  Movie({
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.rating,
    required this.backpath,
    required this.language,
    required this.popularity,
    required this.id

  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'] ?? 'No Title',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      rating: json['vote_average']?? '',
      backpath: json['backdrop_path']??'',
      language: json['original_language']??'',
      popularity: json['popularity']??'',
      id: json['id']??''
      
    );
  }
}
