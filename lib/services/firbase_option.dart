import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

var db = FirebaseFirestore.instance;

class FirebaseOperations {
  static addData(String fullname, String mobileno, String Password) {
    String resp = '';
    final User = <String, dynamic>{
      "Fullname": fullname,
      "Mobileno": mobileno,
      "Password": Password,
      "tr_dt": DateTime.now().toString(),
    };
    db.collection("Users").add(User).whenComplete(() {
      resp = 'Users added successfully';
    });
    //     .catchError((e) {
    //   resp = e.toString();
    // });
    return resp;
  }

  static Stream<QuerySnapshot> fetchTransactions() {
    CollectionReference User = db.collection("transactions");
    return User.snapshots();
  }

  static deleteTranscation(String id) {
    String resp = '';
    DocumentReference docRef = db.collection("transactions").doc(id);
    docRef.delete().whenComplete(() {
      resp = 'Transaction deleted successfully';
    });
    return resp;
  }
}
