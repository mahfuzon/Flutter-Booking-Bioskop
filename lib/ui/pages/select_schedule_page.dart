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
  // menampung waktu yang dipilih user
  int selectedTime;
  // menampung bioskop yang dipilih user
  Theater selectedTheater;
  // digunakan untuk mengecek waktu dan theater yang dipilih sesuai
  bool isValid = false;

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
                // WIDGET: Pilih Bioskop
                generateTimeTable(),
                SizedBox(height: 10),
                // WIDGET: Button Next
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // karena membutuhkan nama user yang login maka di gunakan blocBuilder
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, userState) => FloatingActionButton(
                        elevation: 0,
                        backgroundColor:
                            (isValid) ? mainColor : Color(0XFFE4E4E4),
                        onPressed: () {
                          if (isValid) {
                            context.bloc<PageBloc>().add(
                                  GoToSelectSeatsPage(
                                    // membutuhkan objek Ticket
                                    Ticket(
                                      widget.movieDetail,
                                      selectedTheater,
                                      // saat inisialisasi objel DateTime Maka memerlukan beberapa Parameter
                                      DateTime(
                                          selectedDate.year,
                                          selectedDate.month,
                                          selectedDate.day,
                                          selectedTime),
                                      randomAlphaNumeric(12).toUpperCase(),
                                      null,
                                      (userState as UserLoaded).user.name,
                                      null,
                                    ),
                                  ),
                                );
                          }
                        },
                        child: Icon(
                          Icons.arrow_forward,
                          color: (isValid) ? Colors.white : Color(0XFFBEBEBE),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
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

  Column generateTimeTable() {
    // Membuat list jam dengan jeda tiap jam adalah 2 jam
    List<int> schedule = List.generate(7, (index) => 10 + index * 2);
    // list untuk menampung widget yang berisikan nama bioskop
    List<Widget> widget = [];
    // WIDGET: Nama Bioskop
    for (var theater in dummyTheater) {
      widget.add(
        Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
          child: Text(
            theater.name,
            style: blackTextFont.copyWith(fontSize: 20),
          ),
        ),
      );

      // WIDGET: Jam Tayang
      widget.add(
        Container(
          height: 50,
          margin: EdgeInsets.only(bottom: 20),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: schedule.length,
            itemBuilder: (_, index) => Container(
              margin: EdgeInsets.only(
                  left: (schedule[index] == 0) ? defaultMargin : 16,
                  right: (schedule[index] == schedule.length - 1)
                      ? defaultMargin
                      : 0),
              child: SelectableBox(
                "${schedule[index]}:00",
                // mengecek apakah jam yang dipilih sesuai dengan bioskopnya
                isSelected: selectedTheater == theater &&
                    selectedTime == schedule[index],
                // selectedBox hanya bisa digunakan jika jam tayang lebih besar dari waktu sekarang dan harinya tidak sama dengan hari ini
                isEnabled: schedule[index] > DateTime.now().hour ||
                    selectedDate.day != DateTime.now().day,
                onTap: () {
                  setState(() {
                    selectedTheater = theater;
                    selectedTime = schedule[index];
                    isValid = true;
                  });
                },
              ),
            ),
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget,
    );
  }
}
