import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

var db = FirebaseFirestore.instance;

class FirebaseOperations {
  // static tokendetail(String description, String Date, String Time) {
  //   String resp = '';
  //   final tokens = <String, dynamic>{
  //     "Date": Date,
  //     "Time": Time,
  //     "Description": description,
  //     // "tr_dt": DateTime.now().toString(),
  //   };
  //   db.collection("TokenDetails").add(tokens).whenComplete(() {
  //     resp = 'Users token added successfully';
  //   });
  //   //     .catchError((e) {
  //   //   resp = e.toString();
  //   // });
  //   return resp;
  // }
  static Future<String> tokendetail(
      String description, String Date, String Time) async {
    try {
      final token = <String, dynamic>{
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
