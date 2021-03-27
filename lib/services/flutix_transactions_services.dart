part of 'services.dart';

class FlutixTransactionServices {
  static CollectionReference transactionCollection =
      Firestore.instance.collection('transactions');

  static Future<void> saveTransaction(
      FlutixTransactions flutixTransactions) async {
    await transactionCollection.document().setData({
      'userID': flutixTransactions.userId,
      'title': flutixTransactions.title,
      'subtitle': flutixTransactions.subtitle,
      'amount': flutixTransactions.amount,
      'time': flutixTransactions.time,
      'picture': flutixTransactions.picture
    });
  }

  static Future<List<FlutixTransactions>> getTransaction(String userID) async {
    QuerySnapshot snapshot = await transactionCollection.getDocuments();

    var documents = snapshot.documents
        .where((document) => document.data['userID'] == userID);

    return documents
        .map((e) => FlutixTransactions(
              userId: e.data['userID'],
              title: e.data['title'],
              subtitle: e.data['subtitle'],
              time: DateTime.fromMillisecondsSinceEpoch(e.data['time']),
              amount: e.data['amount'],
              picture: e.data['picture'],
            ))
        .toList();
  }
}
