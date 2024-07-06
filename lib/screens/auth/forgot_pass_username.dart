import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../../utils/app_colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  Future<void> _sendResetEmail() async {
    final email = _emailController.text.trim();

    if (email.isNotEmpty) {
      // Check if the email exists in the database
      final query = QueryBuilder<ParseUser>(ParseUser.forQuery())
        ..whereEqualTo('email', email);

      final response = await query.query();

      if (response.success && response.results != null && response.results!.isNotEmpty) {
        // Email exists, send reset password key (here you would implement sending email logic)
        final user = response.results!.first as ParseUser;
        print('User found: $user');

        // Implement email sending logic here

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset email sent successfully')),
        );
      } else {
        // Email not found in the database
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email not found')),
        );
      }
    } else {
      // Show an error message if the email is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final contentHeight = screenHeight - 200; // Adjust the content height

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false, // Disable automatic resize
        body: Stack(
          fit: StackFit.expand, // Expand the stack to the full screen
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.primaryGradientColor,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 60.0, left: 22),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                constraints: BoxConstraints(maxHeight: contentHeight),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 18.0,
                    right: 18,
                    top: 24,
                    bottom: 24,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                          labelText: "Email:",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: _sendResetEmail,
                        child: Container(
                          height: 55,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              colors: AppColors.primaryGradientColor,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Send Reset Email",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 150),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
