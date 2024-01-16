import 'package:cloud_firestore/cloud_firestore.dart';

var db = FirebaseFirestore.instance;

class FirebaseOperations {
  static Future<String> tokendetail(
      String description, String Date, String Time) async {
    try {
      QuerySnapshot querySnapshot = await db.collection('TokenDetails').get();
      int tokenCount = querySnapshot.docs.length + 1;
      // String waitingTime = await calculateWaitingTime(Date, Time);
      int currentTokenNumber = tokenCount;
      String waitingTime =
          await calculateWaitingTime(Date, Time, currentTokenNumber);
      final token = <String, dynamic>{
        "Token Number": tokenCount,
        "Date": Date,
        "Time": Time,
        "Description": description,
        "Waiting Time": waitingTime,
        "tr_dt": DateTime.now().toString(),
      };

      await db.collection("TokenDetails").add(token);

      return 'Users token added successfully';
    } catch (e) {
      print('Error adding token: $e');
      return 'Failed to add token';
    }
  }

  // static Future<String> calculateWaitingTime(
  //     String currentDate, String currentTime) async {
  //   QuerySnapshot querySnapshot = await db
  //       .collection('TokenDetails')
  //       .orderBy("tr_dt", descending: true)
  //       .limit(2)
  //       .get();

  //   if (querySnapshot.docs.length >= 2) {
  //     String previousTokenTime = querySnapshot.docs[1].get('tr_dt');

  //     DateTime currentDateTime = DateTime.parse('$currentDate $currentTime');
  //     DateTime previousDateTime = DateTime.parse(previousTokenTime);

  //     int diffInSeconds =
  //         currentDateTime.difference(previousDateTime).inSeconds;
  //     int waitingTime =
  //         diffInSeconds >= 900 ? 1200 : 900; // 15 mins or 20 mins in seconds

  //     int minutes = waitingTime ~/ 60;
  //     int seconds = waitingTime % 60;

  //     return '$minutes minutes $seconds seconds';
  //   } else {
  //     return 'Waiting time calculation not available';
  //   }
  // }
  static Future<String> calculateWaitingTime(
      String currentDate, String currentTime, int tokenNumber) async {
    QuerySnapshot querySnapshot = await db
        .collection('TokenDetails')
        .orderBy("tr_dt", descending: true)
        .limit(2)
        .get();

    if (querySnapshot.docs.length >= 2) {
      String previousTokenTime = querySnapshot.docs[1].get('Time');
      int previousTokenNumber =
          querySnapshot.docs[1].get('Token Number') as int;

      DateTime currentDateTime = DateTime.parse('$currentDate $currentTime');
      DateTime previousDateTime = DateTime.parse(previousTokenTime);

      if (tokenNumber == 1) {
        // If the current token number is 1, it's the user's turn
        return 'Your Turn';
      } else if (tokenNumber - previousTokenNumber == 1) {
        // If the current token is in sequence after the previous token
        int diffInSeconds =
            currentDateTime.difference(previousDateTime).inSeconds;
        int waitingTime =
            diffInSeconds >= 900 ? 1200 : 900; // 15 mins or 20 mins in seconds

        int minutes = waitingTime ~/ 60;
        int seconds = waitingTime % 60;

        return '$minutes minutes $seconds seconds';
      } else {
        // If the current token is not in sequence after the previous token
        return 'After 10-15 mins'; // Provide the default waiting time
      }
    } else {
      return 'Waiting time calculation not available';
    }
  }

  static Stream<QuerySnapshot> fetchTransactions() {
    CollectionReference tokens = db.collection("tokens");
    return tokens.snapshots();
  }

  static deleteTranscation(String id) {
    String resp = '';
    DocumentReference docRef = db.collection("tokens").doc(id);
    docRef.delete().whenComplete(() {
      resp = 'Token deleted successfully';
    });
    return resp;
  }
}
