import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:token_generation_application/user_screen/token_status.dart';
import 'package:token_generation_application/user_screen/book_token_screen.dart';
import 'package:token_generation_application/user_screen/login_screen.dart';
import 'package:token_generation_application/user_screen/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<void> _showLogoutConfirmationDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout Confirmation'),
          content: Text('Are you sure you want to log out from the app?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.blue),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.blue),
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Perform logout actions here, such as clearing user session, etc.
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Get.to(() => ProfilePage());
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.home),
            //   title: Text(
            //     'Home',
            //     style: TextStyle(
            //       fontSize: 15,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => BottomNavScreen(),
            //       ),
            //     );
            //   },
            // ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text(
                'Rate of us',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => RateofusScreen(),
              //     ),
              //   );
              // },
            ),
            ListTile(
              leading: Icon(Icons.message_sharp),
              title: Text(
                'Share Feedback',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Get.off(
                  LoginScreen(),
                  curve: Curves.easeInBack,
                  duration: Duration(seconds: 5),
                );
                _showLogoutConfirmationDialog(); // Show the logout confirmation dialog
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            // Scaffold.of(context).openDrawer();
            _scaffoldKey.currentState?.openDrawer();
          },
          child: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: Icon(Icons.menu),
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
        ],
      ),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 100,
              width: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => BookTokenScreen(),
                          curve: Curves.elasticIn,
                          duration: Duration(seconds: 1));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ' Generate \n   Token',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                        // Icon(
                        //   Icons.token_rounded,
                        //   color: Colors.blue,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              width: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => TokenStatusScreen(),
                          curve: Curves.elasticIn,
                          duration: Duration(seconds: 1));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ' Token \n Status',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                        // Icon(
                        //   Icons.token_rounded,
                        //   color: Colors.blue,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
