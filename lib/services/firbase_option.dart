import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

var db = FirebaseFirestore.instance;

class FirebaseOperations {
  static addData(
      String fullname, String mobileno, String Password, String Accoutno) {
    String resp = '';
    final User = <String, dynamic>{
      "Password": Password,
      "Fullname": fullname,
      "Mobileno": mobileno,
      "Accountno": Accoutno,
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

  static Stream<QuerySnapshot> fetchdata() {
    CollectionReference User = db.collection("transactions");
    return User.snapshots();
  }

  static deletedata(String id) {
    String resp = '';
    DocumentReference docRef = db.collection("transactions").doc(id);
    docRef.delete().whenComplete(() {
      resp = 'Userdata deleted successfully';
    });
    return resp;
  }
}
