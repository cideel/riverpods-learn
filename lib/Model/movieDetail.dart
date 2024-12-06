class MovieDetail {
  final String title;
  final List<dynamic> genres;
  final List<dynamic> cast;
  final String releaseDate;
  final int runtime;
  final List<dynamic> studio;


  MovieDetail({
    required this.title,
    required this.genres,
    required this.cast,
    required this.releaseDate,
    required this.runtime,
    required this.studio,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json, List<dynamic> castJson) {
    return MovieDetail(
      title: json['title'],
      genres: json['genres'],
      cast: castJson,
      releaseDate: json['release_date'],
      runtime: json['runtime'],
      studio: json['production_companies']??'',

    );
  }
}
