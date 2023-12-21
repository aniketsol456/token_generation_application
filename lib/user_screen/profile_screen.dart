import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  // const ProfilePage({super.key});
  const ProfilePage({Key? key}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // TextEditingController fullname = TextEditingController();
  // TextEditingController accountnum = TextEditingController();
  // TextEditingController phonenum = TextEditingController();
  late TextEditingController fullname;
  late TextEditingController accountnum;
  late TextEditingController phonenum;
  // late String fullName = '';
  // late String accoutnumber = '';
  // late String phoneNumber = '';

  @override
  void initState() {
    super.initState();
    fullname = TextEditingController();
    accountnum = TextEditingController();
    phonenum = TextEditingController();
    fetchProfileData(); // Fetch data when the page initializes
  }

  void fetchProfileData() async {
    try {
      // Access Firestore collection 'profiles' and document with specific ID
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('Users')
          .doc('xPdpuq1Loo8kgY95Triy')
          .get();

      if (snapshot.exists) {
        // Access data from the snapshot and set it to the respective TextFields
        setState(() {
          fullname.text = snapshot.get('fullName') ??
              ''; // Setting retrieved data to the TextField
          accountnum.text = snapshot.get('accountNumber') ?? '';
          phonenum.text = snapshot.get('phoneNumber') ?? '';
        });
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
    phonenum.dispose();
    super.dispose();
  }

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: fullname,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          // hintText: 'Full Name',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: phonenum,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Phone number',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: accountnum,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Account Number',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
