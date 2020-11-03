part of "models.dart";

// membuat kelas turunan dari class Movie
class MovieDetail extends Movie {
  final List<String> genres;
  final String language;

  MovieDetail(Movie movie, {this.genres, this.language})
      // memanggil konstruktor class Movie
      : super(
          id: movie.id,
          title: movie.title,
          voteAverage: movie.voteAverage,
          overView: movie.overView,
          posterPath: movie.posterPath,
          backdropPath: movie.backdropPath,
        );

  // membuat getter untuk mengembalikan nilai --
  // genre dan language dalam format tertentu
  String get genresAndLanguage {
    String s = "";

    for (var genre in genres) {
      s += genre + (genre != genres.last ? ',' : "");
    }
    return "$s - $language";
  }

  @override
  List<Object> get props => super.props;
}
