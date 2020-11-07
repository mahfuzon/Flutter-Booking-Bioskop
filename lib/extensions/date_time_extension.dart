part of "extensions.dart";

// membuat sebuah extenion untuk mengubah format waktu
extension DateRimeExtension on DateTime {
  // membuat sebuah getter
  String get shortDayName {
    // membandingkan setiap hari dalam satu minggu dengan percabangan melalui index
    switch (this.weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      default:
        return "Sun";
    }
  }
}
