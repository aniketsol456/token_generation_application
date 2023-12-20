import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

var db = FirebaseFirestore.instance;

class FirebaseOperations {
  static tokendetail(String description) {
    String resp = '';
    final token = <String, dynamic>{
      "Description": description,
      "tr_dt": DateTime.now().toString(),
    };
    db.collection("TokenDetails").add(token).whenComplete(() {
      resp = 'Users token added successfully';
    });
    //     .catchError((e) {
    //   resp = e.toString();
    // });
    return resp;
  }

  static Stream<QuerySnapshot> fetchTransactions() {
    CollectionReference token = db.collection("transactions");
    return token.snapshots();
  }

  static deleteTranscation(String id) {
    String resp = '';
    DocumentReference docRef = db.collection("transactions").doc(id);
    docRef.delete().whenComplete(() {
      resp = 'Token deleted successfully';
    });
    return resp;
  }
}
