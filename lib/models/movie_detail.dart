part of "models.dart";

class MovieDetail extends Movie {
  final List<String> genres;
  final String language;

  MovieDetail(Movie movie, {this.genres, this.language})
      : super(
          id: movie.id,
          posterPath: movie.posterPath,
          title: movie.title,
          voteAverage: movie.voteAverage,
          overView: movie.overView,
          backdropPath: movie.backdropPath,
        );

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
