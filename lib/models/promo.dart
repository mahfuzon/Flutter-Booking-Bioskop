part of "models.dart";

class Promo extends Equatable {
  final String title;
  final String subtitle;
  final int discount;

  Promo(
      {@required this.title, @required this.subtitle, @required this.discount});
  @override
  // TODO: implement props
  List<Object> get props => [title, subtitle, discount];
}

List<Promo> dummy_promo = [
  Promo(
      title: "Student Holiday",
      discount: 50,
      subtitle: 'Maximal only for 2 people'),
  Promo(
      discount: 70,
      subtitle: "Minimal for three members",
      title: "Fammily Club"),
  Promo(title: "Subcription Promo", subtitle: "Min one Year", discount: 40)
];
