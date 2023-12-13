import 'package:flutter/material.dart';
import 'package:token_generation_application/Screen/home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _showPassword = true;

  String _fullName = '';
  String _phoneNumber = '';
  String _password = '';
  String _confirmPassword = '';

  bool _isValidFullName = true;
  bool _isValidPhoneNumber = true;
  bool _isValidPassword = true;
  bool _isValidConfirmPassword = true;

  void validationofform() {
    setState(() {
      _isValidFullName = _fullName.isNotEmpty;
      _isValidPhoneNumber =
          _phoneNumber.isNotEmpty && _phoneNumber.length == 10;
      _isValidPassword = _password.isNotEmpty && _password.length >= 8;
      _isValidConfirmPassword =
          _confirmPassword == _password && _confirmPassword.isNotEmpty;
    });
  }

  void ToshowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 85, 161, 223),
      body: Center(
        child: Container(
          width: 300,
          height: 550,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  'Create an Account',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Full name',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: InputBorder.none,
                      errorText: !_isValidFullName
                          ? 'Please enter valid fullname'
                          : null,
                    ),
                    onChanged: (value) {
                      _fullName = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    //controller: controller.phone,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Enter a Mobile No.',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      errorText: !_isValidPhoneNumber
                          ? 'Please enter valid Mobilename'
                          : null,
                    ),
                    onChanged: (value) {
                      _phoneNumber = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    obscureText: _showPassword,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Create a Password',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      errorText: !_isValidPassword
                          ? 'Please enter valid Password'
                          : null,
                      suffixIcon: IconButton(
                        onPressed: ToshowPassword,
                        icon: Icon(_showPassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                    onChanged: (value) {
                      _password = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    obscureText: _showPassword,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Re-Enter a Password',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      errorText: !_isValidConfirmPassword
                          ? 'entered password is not same'
                          : null,
                      suffixIcon: IconButton(
                        onPressed: ToshowPassword,
                        icon: Icon(_showPassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                    onChanged: (value) {
                      _confirmPassword = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}