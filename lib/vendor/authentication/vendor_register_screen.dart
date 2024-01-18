import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../views/screens/widgets/button_widget.dart';
import '../../views/screens/widgets/custom_text_Field.dart';
import '../controllers/vendor_controller.dart';
import 'Create_store_screen.dart';

class VendorRegisterScreen extends StatefulWidget {
  @override
  State<VendorRegisterScreen> createState() => _VendorRegisterScreenState();
}

class _VendorRegisterScreenState extends State<VendorRegisterScreen> {
  final VendorController _vendorController = VendorController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late String comapanyName;

  late String companyNumber;

  late String address;

  late String companyId;

  late String email;

  late String password;

  registerUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String res = await _vendorController.createNewUser(
          email, comapanyName, companyNumber, password, address, companyId);

      setState(() {
        _isLoading = false;
      });

      if (res == 'success') {
        Get.to(CreateStoreScreen());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Your account has been created. Check for a confirmation email.')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Uh-Oh! Something went wrong!'),
          ),
        );
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Vendor Registration',
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/Illustration.png',
                      width: 200,
                      height: 200,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      label: "What is your store called?",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/images/user.png',
                          color: Colors.cyan,
                          width: 20,
                          height: 20,
                        ),
                      ),
                      text: 'Enter the name of your business',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Store name cannot be blank!';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        comapanyName = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      label: 'Do you have a contact number?',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/images/phone.png',
                          color: Colors.cyan,
                          width: 20,
                          height: 20,
                        ),
                      ),
                      text: 'Enter your phone number',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone number cannot be empty!';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        companyNumber = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      label: 'Where is your business located?',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/images/location.png',
                          color: Colors.cyan,
                          width: 20,
                          height: 20,
                        ),
                      ),
                      text: 'Enter your location',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Location is invalid.';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        address = value;
                      },
                    ),
                    CustomTextField(
                      label: 'Business Registration (OPTIONAL)',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/images/card.png',
                          color: Colors.cyan,
                          width: 20,
                          height: 20,
                        ),
                      ),
                      text: 'If you are registered - enter company ID',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid Company ID';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        companyId = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      label: 'Business Email',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/icons/email.png',
                          color: Colors.cyan,
                          width: 20,
                          height: 20,
                        ),
                      ),
                      text: 'Enter your business email',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enter email ';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      label: 'Create a password for your storefront',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/icons/password.png',
                          color: Colors.cyan,
                          width: 20,
                          height: 20,
                        ),
                      ),
                      text: 'enter your password',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enter password ';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonWidgets(
            buttonChange: () {
              registerUser();
            },
            isLoading: _isLoading ? true : false,
            buttonTitle: 'Sign up',
          ),
        ],
      ),
    );
  }
}
