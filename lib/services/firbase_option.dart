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

  static Future<bool> checkUserExists(String mobileno, String Password) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Users')
        .where('Mobileno', isEqualTo: mobileno)
        .where('Password', isEqualTo: Password)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  static Stream<QuerySnapshot> fetchdata() {
    CollectionReference Users = db.collection("Users");
    return Users.snapshots();
  }

  static deletedata(String id) {
    String resp = '';
    DocumentReference docRef = db.collection("Users").doc(id);
    docRef.delete().whenComplete(() {
      resp = 'Userdata deleted successfully';
    });
    return resp;
  }
}
