part of "pages.dart";

class SelectSchedulePage extends StatefulWidget {
  // properti movieDetail digunakan untuk dijadikan parameter saat kembali ke Page MovieDetailPage
  final MovieDetail movieDetail;

  SelectSchedulePage(this.movieDetail);

  @override
  _SelectSchedulePageState createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  // properti date digunakan untuk menampung hari dalam seminggu yang digunakan dalam kasus ini
  List<DateTime> dates;
  // properti untuk menampung tanggal yang dipilih user
  DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    // mengisikan sebuah List sebanyak 7 hari dari hari sekarang
    dates =
        List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
    // memberikan nilai default pada selectedDate untuk memilih hari sekarang
    selectedDate = dates[0];
  }

  @override
  Widget build(BuildContext context) {
    // Widget WiilPopScope digunakan untuk memberikan action back pada tombol back hp
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMovieDetailPage(widget.movieDetail));
        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Bilah Notifikasi
            Container(color: accentColor1),
            // Widget SafeArea bertujuan untuk memberikan warna default pada latar belakang
            SafeArea(
              child: Container(color: Colors.white),
            ),
            ListView(
              children: [
                // WIDGET: Back Icon
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20, left: defaultMargin),
                      padding: EdgeInsets.all(1),
                      child: GestureDetector(
                        onTap: () {
                          context
                              .bloc<PageBloc>()
                              .add(GoToMovieDetailPage(widget.movieDetail));
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                // WIDGET: Pilih Tanggal
                Container(
                  margin: EdgeInsets.fromLTRB(
                    defaultMargin,
                    20,
                    defaultMargin,
                    16,
                  ),
                  child: Text(
                    "Choose Date",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 24),
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dates.length,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.only(
                        left: (index == 0) ? defaultMargin : 0,
                        right: (index < dates.length - 1) ? 16 : defaultMargin,
                      ),
                      child: DateCard(
                          // mengisikan properti tanggal pada widget dateCard yang diambil dari list dates
                          date: dates[index],
                          // isSelected akan bernilai true jika selectedDate == waktu sekarang
                          isSelected: selectedDate == dates[index],
                          onTap: () {
                            setState(() {
                              selectedDate = dates[index];
                            });
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
