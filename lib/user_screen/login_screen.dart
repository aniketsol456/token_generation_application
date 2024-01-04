// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:token_generation_application/admin_screen/admin_home_screen.dart';
import 'package:token_generation_application/services/firbase_option.dart';
import 'package:token_generation_application/user_screen/home_screen.dart';
import 'package:token_generation_application/user_screen/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController Numcontroller = TextEditingController();
  TextEditingController Passcontroller = TextEditingController();

  bool _showPassword = true;
  String? numerrortext;
  String? passerrortext;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Check login status from SharedPreferences
    SharedPreferences.getInstance().then((prefs) async {
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      print('islogin:$isLoggedIn');
      if (isLoggedIn) {
        // If already logged in, directly navigate to HomeScreen
        Get.off(HomeScreen());
      }
    });
  }

  void NavigateToSignup() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignupScreen()));
  }

  // void NavigateToBootomNav() {
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => BottomNavScreen(),
  //     ),
  //   );
  // }

  // void NavigateToBootomNav() {
  //   setState(() {
  //     numerrortext =
  //         (Numcontroller.text.isEmpty) ? "Please enter a Mobile number" : null;
  //     passerrortext =
  //         (Passcontroller.text.isEmpty) ? "Please enter a Password" : null;
  //   });
  //   if (Numcontroller.text == '9104525299' &&
  //       Passcontroller.text == 'admin_123') {
  //     Get.off(
  //       AdminHomeScreen(),
  //     );
  //   } else if (numerrortext == null && passerrortext == null) {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => HomeScreen()),
  //     );
  //   }
  // }

  // void NavigateToBootomNav() async {
  //   setState(() {
  //     numerrortext =
  //         (Numcontroller.text.isEmpty) ? "Please enter a Mobile number" : null;
  //     passerrortext =
  //         (Passcontroller.text.isEmpty) ? "Please enter a Password" : null;
  //   });

  //   if (numerrortext == null && passerrortext == null) {
  //     bool isAdmin = (Numcontroller.text == '9104525299' &&
  //         Passcontroller.text == 'admin_123');

  //     if (isAdmin) {
  //       // Admin login
  //       Get.off(AdminHomeScreen());
  //     } else {
  //       // User login
  //       bool userExists = await FirebaseOperations.checkUserExists(
  //           Numcontroller.text, Passcontroller.text);

  //       if (userExists) {
  //         // User exists in the database, navigate to HomeScreen
  //         // Navigator.pushReplacement(
  //         //   context,
  //         //   MaterialPageRoute(builder: (context) => HomeScreen()),
  //         // );
  //         Get.to(
  //           HomeScreen(),
  //           curve: Curves.easeInCubic,
  //           duration: Duration(seconds: 2),
  //         );
  //       } else {
  //         // User doesn't exist, show a message or navigate to signup page
  //         // You can show a snackbar or dialog indicating that the user doesn't exist
  //         // or navigate to the signup page
  //         // Navigator.pushReplacement(
  //         //   context,
  //         //   MaterialPageRoute(builder: (context) => SignupScreen()),
  //         // );
  //         Get.to(
  //           SignupScreen(),
  //           curve: Curves.easeInCubic,
  //           duration: Duration(seconds: 2),
  //         );
  //       }
  //     }
  //   }
  // }

  Future<void> handleLogin() async {
    bool isAdmin = (Numcontroller.text == '9104525299' &&
        Passcontroller.text == 'admin_123');

    if (isAdmin) {
      // Admin login
      Get.off(AdminHomeScreen());
    } else {
      // Check login status from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      print('islogin:$isLoggedIn');
      if (isLoggedIn) {
        // If already logged in, directly navigate to HomeScreen
        Get.off(HomeScreen());
      } else {
        // If not logged in, proceed with the login process
        await performLogin();
      }
    }
  }

  Future<void> performLogin() async {
    setState(() {
      numerrortext =
          (Numcontroller.text.isEmpty) ? "Please enter a Mobile number" : null;
      passerrortext =
          (Passcontroller.text.isEmpty) ? "Please enter a Password" : null;
    });

    if (numerrortext == null && passerrortext == null) {
      String userExists = await FirebaseOperations.checkUserExists(
          Numcontroller.text, Passcontroller.text);

      if (userExists.isNotEmpty) {
        // User exists in the database, navigate to HomeScreen
        saveLoginStatus(true, userExists); // Save login status
        Get.off(HomeScreen());
      } else {
        // User doesn't exist, navigate to signup page
        Get.to(SignupScreen());
      }
    }
  }

  Future<void> saveLoginStatus(bool isLoggedIn, String userExists) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
    await prefs.setString('uid', userExists);
  }

  void ToshowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 85, 161, 223),
      body: Center(
        child: Container(
          width: 300,
          height: 400,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black, width: 3),
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Enter Your Detail',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: Numcontroller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Enter a Mobile number',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      errorText: numerrortext,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: Passcontroller,
                    obscureText: _showPassword,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Password',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      errorText: passerrortext,
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        onPressed: ToshowPassword,
                        icon: Icon(_showPassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: handleLogin,
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("don't have an account?  "),
                    TextButton(
                      onPressed: NavigateToSignup,
                      child: Text(
                        "Sign up.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
