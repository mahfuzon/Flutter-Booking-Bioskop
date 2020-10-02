part of 'widgets.dart';

class MovieCard extends StatelessWidget {
  final Movie movies;
  final Function onTap;

  MovieCard(this.movies, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 210,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: NetworkImage(imageBaseURL + "w700" + movies.backdropPath),
        ),
      ),
      child: Container(
        height: 140,
        width: 210,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.61),
              Colors.black.withOpacity(0)
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movies.title,
              style: whiteTextFont,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            RaitingStars(
              voteAverage: movies.voteAverage,
            ),
          ],
        ),
      ),
    );
  }
}
