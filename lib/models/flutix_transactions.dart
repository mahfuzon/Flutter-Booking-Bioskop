part of 'models.dart';

class FlutixTransactions extends Equatable {
  final String userId;
  final String title;
  final String subtitle;
  final int amount;
  final DateTime time;
  final String picture;

  FlutixTransactions(
      {this.userId,
      this.title,
      this.subtitle,
      this.time,
      this.amount = 0,
      this.picture});

  @override
  // TODO: implement props
  List<Object> get props => [userId, title, subtitle, amount, time, picture];
}
