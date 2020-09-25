part of "pages.dart";

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // HEADER
        Container(
            padding: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 30),
            decoration: BoxDecoration(
              color: accentColor1,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            // CONTENT
            child: BlocBuilder<UserBloc, UserState>(
              builder: (_, userState) {
                if (userState is UserLoaded) {
                  if (imageFileToUpload != null) {
                    uploadImage(imageFileToUpload).then((downloadURL) {
                      imageFileToUpload = null;
                      context
                          .bloc<UserBloc>()
                          .add(UpdateData(profileImage: downloadURL));
                    });
                  }
                  return Row(
                    children: [
                      // IMAGE
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xff5f5588),
                            width: 1,
                          ),
                        ),
                        child: Stack(
                          children: [
                            SpinKitFadingCircle(color: accentColor2, size: 50),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: (userState.user.profilePicture == "")
                                      ? AssetImage("assets/user_pic.png")
                                      : NetworkImage(
                                          userState.user.profilePicture),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // AKHIR IMAGE
                      SizedBox(
                        width: 16,
                      ),
                      // NAMA DAN SALDO
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // NAMA
                          SizedBox(
                            width: MediaQuery.of(context).size.width -
                                2 * defaultMargin -
                                78,
                            child: Text(
                              userState.user.name,
                              style: whiteTextFont.copyWith(fontSize: 18),
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          // AKHIR NAMA
                          // SALDO
                          Text(
                            NumberFormat.currency(
                                    locale: "id_ID",
                                    decimalDigits: 2,
                                    symbol: "IDR ")
                                .format(userState.user.balance),
                            style: yellowNumberFont.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          // AKHIR SALDO
                        ],
                      ),
                      // AKHIR NAMA DAN SALDO
                    ],
                  );
                } else {
                  return SpinKitFadingCircle(
                    color: accentColor2,
                    size: 50,
                  );
                }
              },
            )
            // AKHIR CONTENT
            ),
        // AKHIR HEADER
        // ISI MOVIE
        Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text("Now Playing",
              style: blackTextFont.copyWith(
                  fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 140,
          child: BlocBuilder<MovieBloc, MovieState>(builder: (_, movieState) {
            if (movieState is MovieLoaded) {
              List<Movie> movies = movieState.movies.sublist(0, 10);
              return ListView.builder(
                itemBuilder: (_, index) => Container(
                  margin: EdgeInsets.all(5),
                  child: Text(movies[index].title),
                ),
                itemCount: movies.length,
                scrollDirection: Axis.horizontal,
              );
            } else {
              return SpinKitFadingCircle(color: mainColor, size: 50);
            }
          }),
        ),
        // AKHIR ISI MOVIE
      ],
    );
  }
}
