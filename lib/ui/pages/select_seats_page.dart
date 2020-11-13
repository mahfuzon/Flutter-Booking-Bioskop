part of "pages.dart";

class SelectSeatsPage extends StatefulWidget {
  final Ticket ticket;

  SelectSeatsPage(this.ticket);
  @override
  _SelectSeatsPageState createState() => _SelectSeatsPageState();
}

class _SelectSeatsPageState extends State<SelectSeatsPage> {
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
        body: Center(
          child: Text(widget.ticket.bookingCode),
        ),
      ),
    );
  }
}
