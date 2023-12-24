import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController fullname = TextEditingController();
  TextEditingController accountnum = TextEditingController();
  TextEditingController mobilenum = TextEditingController();
  // late String fullName = '';
  // late String accoutnumber = '';
  // late String phoneNumber = '';
  // TextEditingController fullname = TextEditingController();
  // TextEditingController accountnum = TextEditingController();
  // TextEditingController phonenum = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProfileData(); // Fetch data when the page initializes
  }

  // Future<void> fetchProfileData() async {
  //   try {
  //     // Access Firestore collection 'Users' and get the documents
  //     QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //         await FirebaseFirestore.instance.collection('Users').get();

  //     if (querySnapshot.docs.isNotEmpty) {
  //       // Assume you're fetching the first document found in the collection
  //       // You can modify this according to your specific logic
  //       var userData = querySnapshot.docs.first.data();

  //       setState(() {
  //         fullname.text = userData['Fullname'] ?? '';
  //         accountnum.text = userData['Accountno'] ?? '';
  //         mobilenum.text = userData['Mobileno'] ?? '';
  //       });
  //     }
  //   } catch (e) {
  //     print('Error fetching profile data: $e');
  //     // Handle errors here
  //   }
  // }

  Future<void> fetchProfileData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Access Firestore collection 'Users' and get the document for the logged-in user
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('Users')
                .doc(user.uid) // Assuming user ID is used as the document ID
                .get();

        if (snapshot.exists) {
          var userData = snapshot.data();

          setState(() {
            fullname.text = userData?['Fullname'] ?? '';
            accountnum.text = userData?['Accountno'] ?? '';
            mobilenum.text = userData?['Mobileno'] ?? '';
          });
        }
      }
    } catch (e) {
      print('Error fetching profile data: $e');
      // Handle errors here
    }
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    fullname.dispose();
    accountnum.dispose();
    mobilenum.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Icon(
                Icons.person,
                size: 150,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: fullname,
                  decoration: InputDecoration(
                    hintText: 'Fullname',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: mobilenum,
                  decoration: InputDecoration(
                    hintText: 'Mobileno',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: accountnum,
                  decoration: InputDecoration(
                    hintText: 'Accountno',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
