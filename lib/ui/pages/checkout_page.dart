part of "pages.dart";

class CheckoutPage extends StatefulWidget {
  final Ticket ticket;

  CheckoutPage(this.ticket);
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSelectSeatsPage(widget.ticket));
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(color: accentColor1),
            SafeArea(
              child: Container(color: Colors.white),
            ),
            ListView(
              children: [
                Stack(
                  children: [
                    // WIDGET: ARROW BACK
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20, left: defaultMargin),
                          padding: EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap: () {
                              context
                                  .bloc<PageBloc>()
                                  .add(GoToSelectSeatsPage(widget.ticket));
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, userState) {
                        User user = (userState as UserLoaded).user;
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              child: Text("Checkout\nMovie",
                                  style: blackTextFont.copyWith(fontSize: 20),
                                  textAlign: TextAlign.center),
                            ),
                            // WIDGET: MOVIE DESCRIPTION
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: defaultMargin, left: 20),
                                  width: 70,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: NetworkImage(imageBaseURL +
                                          "w342" +
                                          widget.ticket.movieDetail.posterPath),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          2 * defaultMargin -
                                          70 -
                                          20,
                                      child: Text(
                                        widget.ticket.movieDetail.title,
                                        style: blackTextFont.copyWith(
                                            fontSize: 18),
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                    Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 6),
                                        width:
                                            MediaQuery.of(context).size.width -
                                                2 * defaultMargin -
                                                70 -
                                                20,
                                        child: Text(
                                          widget.ticket.movieDetail
                                              .genresAndLanguage,
                                          style: greyTextFont.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )),
                                    RatingStars(
                                        voteAverage: widget
                                            .ticket.movieDetail.voteAverage,
                                        color: accentColor3),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
