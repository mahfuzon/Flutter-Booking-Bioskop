part of "pages.dart";

class SelectSeatsPage extends StatefulWidget {
  final Ticket ticket;

  SelectSeatsPage(this.ticket);
  @override
  _SelectSeatsPageState createState() => _SelectSeatsPageState();
}

class _SelectSeatsPageState extends State<SelectSeatsPage> {
  List<String> selectedSeats = [];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .bloc<PageBloc>()
            .add(GoToSelectSchedulePage(widget.ticket.movieDetail));
        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: accentColor1,
            ),
            SafeArea(
              child: Container(color: Colors.white),
            ),
            ListView(
              children: [
                Column(
                  children: [
                    // WIDGET: Header
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // WIDGET: Arrow Back
                        Container(
                          margin: EdgeInsets.only(top: 20, left: defaultMargin),
                          padding: EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap: () {
                              context.bloc<PageBloc>().add(
                                  GoToSelectSchedulePage(
                                      widget.ticket.movieDetail));
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        // WIDGET: Poster dan Judul
                        Padding(
                          padding:
                              EdgeInsets.only(top: 20, right: defaultMargin),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 16),
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Text(
                                  widget.ticket.movieDetail.title,
                                  style: blackTextFont.copyWith(fontSize: 20),
                                  maxLines: 2,
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      imageBaseURL +
                                          "w154" +
                                          widget.ticket.movieDetail.posterPath,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // WIDGET: Cinema Screen
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      width: 277,
                      height: 84,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/screen.png"),
                        ),
                      ),
                    ),
                    // WIDGET: SEATS
                    generateSeats(),
                    SizedBox(height: 30),
                    // WIDGET: Button
                    Column(
                      children: [
                        FloatingActionButton(
                          onPressed: () {},
                          elevation: 0,
                          backgroundColor: (selectedSeats.length > 0)
                              ? mainColor
                              : Color(0xFFE4E4E4),
                          child: Icon(
                            Icons.arrow_forward,
                            color: (selectedSeats.length > 0)
                                ? Colors.white
                                : Color(0xFFBEBEBE),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column generateSeats() {
    List<int> numberOfSeats = [3, 5, 5, 5, 5];
    List<Widget> widgets = [];
    for (int i = 0; i < numberOfSeats.length; i++) {
      widgets.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            numberOfSeats[i],
            (index) => Padding(
              padding: EdgeInsets.only(
                right: (index < numberOfSeats.length - 1) ? 16 : 0,
                bottom: 16,
              ),
              child: SelectableBox(
                // baris dilihat dari variabel yang digunakan untuk perulangan
                // sedangkan kolom dilihat dari index nya
                // mendapatkan isi dari selectable box menggunakan code asci
                "${String.fromCharCode(i + 65)}${index + 1}",
                width: 40,
                height: 40,
                textStyle: blackNumberFont,
                isSelected: selectedSeats
                    .contains("${String.fromCharCode(i + 65)}${index + 1}"),
                onTap: () {
                  String seatNumber =
                      "${String.fromCharCode(i + 65)}${index + 1}";
                  setState(
                    () {
                      if (selectedSeats.contains(seatNumber)) {
                        selectedSeats.remove(seatNumber);
                      } else {
                        selectedSeats.add(seatNumber);
                      }
                    },
                  );
                },
                isEnabled: index != 0,
              ),
            ),
          ),
        ),
      );
    }
    return Column(children: widgets);
  }
}
