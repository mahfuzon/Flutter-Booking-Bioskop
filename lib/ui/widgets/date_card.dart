part of "widgets.dart";

class DateCard extends StatelessWidget {
  // properti isSelected menandakan apakah field sudah dipilih atau belum
  final bool isSelected;
  final double width;
  final double height;
  // properti date digunakan untuk menmapilkan date pada field
  final DateTime date;
  final Function onTap;

  const DateCard(
      // memberikan nilai default false pada properti isSelected
      {this.isSelected = false,
      this.width = 70,
      this.height = 90,
      this.date,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    // widget GesturDetector berfungsi untuk memberikan event pada widget
    return GestureDetector(
      onTap: () {
        // apabila properti onTap tidak null maka jalankan function onTap
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          // mengecek apakah nilai properti isSelected bernilai true
          color: (isSelected) ? accentColor2 : Colors.transparent,
          border: Border.all(
            // mengecek apakah properti isSelected bernilai true
            color: (isSelected) ? Colors.transparent : Color(0xFFE4E4E4),
          ),
        ),
        // WIDGET: Hari dan Tanggal
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // menampilkan nama hari dari extension
            Text(
              date.shortDayName,
              style: blackTextFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 6),
            // menampilkan tanggal dari kelas date
            Text(
              date.day.toString(),
              style: blackNumberFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
