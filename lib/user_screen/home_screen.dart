import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:token_generation_application/user_screen/book_token_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => ProfilePage(),
              //     ),
              //   );
              // },
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
              // onTap: () {
              //   // Navigator.push(
              //   //   context,
              //   //   MaterialPageRoute(
              //   //     builder: (context) => LoginScreen(),
              //   //   ),
              //   // );
              //   _showLogoutConfirmationDialog(); // Show the logout confirmation dialog
              // },
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
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
                          duration: Duration(seconds: 3));
                    },
                    child: Row(
                      children: [
                        Text(
                          'Generate \n   Token',
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
