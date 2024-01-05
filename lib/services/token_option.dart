import 'package:cloud_firestore/cloud_firestore.dart';

var db = FirebaseFirestore.instance;

class FirebaseOperations {
  static Future<String> tokendetail(
      String description, String Date, String Time) async {
    try {
      QuerySnapshot querySnapshot = await db.collection('TokenDetails').get();
      int tokenCount = querySnapshot.docs.length + 1;

      final token = <String, dynamic>{
        "Token Number": tokenCount,
        "Date": Date,
        "Time": Time,
        "Description": description,
        "tr_dt": DateTime.now().toString(),
      };

      await db.collection("TokenDetails").add(token);

      return 'Users token added successfully';
    } catch (e) {
      print('Error adding token: $e');
      return 'Failed to add token';
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
