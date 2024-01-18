import 'package:amenity/views/screens/authentication_screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/auth_controller.dart';
import '../main_screen.dart';
import '../widgets/button_widget.dart';
import '../widgets/custom_text_Field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  late String email;

  late String password;

  bool _isLoading = false;

  loginUser() async {
    String loginStatus = ''; // Move the variable inside loginUser

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      Map<String, dynamic> res =
          await _authController.loginUser(email, password);

      setState(() {
        _isLoading = false;
        loginStatus = res['status'];
      });

      if (loginStatus == 'success') {
        String userRole = res['role'];

        if (userRole == 'buyer') {
          Get.offAll(MainScreen());
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Logged in as a buyer')));
        } else {
          // Handle unexpected role or show an error message
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Invalid user role. Please contact support.'),
            backgroundColor: Colors.blue,
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login failed. $loginStatus'),
          backgroundColor: Colors.blue,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(
        0.95,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 70,
                      child: SvgPicture.asset(
                        'assets/images/amenity_name.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      'Shopping at your fingertips!',
                      style: GoogleFonts.roboto(
                        color: Color(0xFF0d120E),
                        fontSize: 14,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(height: 50),
                    CustomTextField(
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your email';
                        } else {
                          return null;
                        }
                      },
                      label: 'Enter your email',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/icons/email.png',
                          color: Colors.cyan,
                          width: 20,
                          height: 20,
                        ),
                      ),
                      text: 'enter email',
                    ),
                    CustomTextField(
                      isPassword: true,
                      onChanged: (value) {
                        password = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your password';
                        } else {
                          return null;
                        }
                      },
                      label: 'Enter your password',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/icons/password.png',
                          color: Colors.cyan,
                          width: 20,
                          height: 20,
                        ),
                      ),
                      text: 'enter password',
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ButtonWidgets(
                      isLoading: _isLoading ? true : false,
                      buttonChange: () {
                        if ((_formKey.currentState!.validate())) {
                          loginUser();
                        } else {}
                      },
                      buttonTitle: 'Sign In',
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(RegisterScreen());
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 30)),
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.cyan),
                      ),
                      child: Text(
                        'Create Account',
                        style: GoogleFonts.roboto(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 80),

                    /// Vendor screen moved into main logic
                    // TextButton(
                    //   onPressed: () {
                    //     Get.to(VendorRegisterScreen());
                    //   },
                    //   child: Text(
                    //     'Want to sell something? Tap here!',
                    //     style: GoogleFonts.roboto(),
                    //   ),
                    // ),
                    // SizedBox(height: 20)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
