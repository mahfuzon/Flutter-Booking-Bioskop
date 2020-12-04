part of "services.dart";

class TicketServices {
  static CollectionReference ticketCollection =
      Firestore.instance.collection('tickets');
  static Future<void> saveTicket(String id, Ticket ticket) async {
    await ticketCollection.document().setData({
      'movieID': ticket.movieDetail.id,
      'userID': id ?? "",
      'theaterName': ticket.theater.name ?? "",
      'time': ticket.time.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
      'bookingCode': ticket.bookingCode,
      'seats': ticket.seats,
      'name': ticket.name,
      'totalPrice': ticket.totalPrice,
    });
  }

  static Future<List<Ticket>> getTicket(String userId) async {
    QuerySnapshot snapshot = await ticketCollection.getDocuments();
    // mengambil kumpulan ticket yang key mya sama dengan userId
    var documents =
        snapshot.documents.where((element) => element.data['userID'] == userId);
    List<Ticket> tickets = [];
    for (var document in documents) {
      MovieDetail movieDetail =
          await MovieServices.getDetails(document.data['movieID']);
      tickets.add(Ticket(
        movieDetail,
        Theater(document.data['theaterName']),
        DateTime.fromMillisecondsSinceEpoch(document.data['time']),
        document.data['bookingCode'],
        document.data['seats'].toString().split(','),
        document.data['name'],
        document.data['totalPrice'],
      ));
    }
    return tickets;
  }
}
