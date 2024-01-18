import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/auth_controller.dart';
import '../widgets/button_widget.dart';
import '../widgets/custom_text_Field.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController _authController = AuthController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  late String email;

  late String fullName;

  late String password;

  registerUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String res = await _authController.createNewUser(
        email,
        fullName,
        password,
      );

      setState(() {
        _isLoading = false;
      });

      if (res == 'success') {
        Get.to(LoginScreen());
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('An account has been created for you..')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('something went wrong'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('please enter all fields')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Create Your Account",
          style: GoogleFonts.roboto(
            color: Color(0xFF0d120E),
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
            fontSize: 23,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                  onChanged: (value) {
                    fullName = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your Full Name';
                    } else {
                      return null;
                    }
                  },
                  label: 'Enter your Full Name',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      'assets/icons/user.jpeg',
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
                ButtonWidgets(
                  isLoading: _isLoading ? true : false,
                  buttonChange: () {
                    if (_formKey.currentState!.validate()) {
                      registerUser();
                    } else {
                      print('failed');
                    }
                  },
                  buttonTitle: 'Sign Up',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
