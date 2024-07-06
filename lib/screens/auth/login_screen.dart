import 'package:classrapp/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../../utils/app_colors.dart';
import 'forgot_pass_username.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false; // Variable to toggle password visibility
  bool _isUsernameValid = false; // Variable to track if the username is entered

  Future<void> _login() async {
    final idno = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (idno.isNotEmpty && password.isNotEmpty) {
      // Create a query to retrieve the user from the "users" class
      final query = QueryBuilder<ParseObject>(ParseObject('users'))
        ..whereEqualTo('idno', int.parse(idno))
        ..whereEqualTo('password', password);

      final response = await query.query();

      if (response.success &&
          response.results != null &&
          response.results!.isNotEmpty) {
        // Login successful, navigate to the home screen
        final user = response.results!.first as ParseObject;
        print('Logged in user: $user');

        // Navigate to the HomeScreen and pass the user data as constructor arguments
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              userName: user.get<String>('name') ?? '',
              idno: user.get<int>('idno')?.toString() ?? '',
            ),
          ),
        );
      } else {
        // Login failed, show an error message
        if (response.error != null) {
          print('Login error: ${response.error!.message}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.error!.message)),
          );
        } else {
          print('Login failed, no user found');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid student number or password')),
          );
        }
      }
    } else {
      // Show an error message if the idno or password is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter your student number and password')),
      );
    }
  }

  void _goToForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
    );
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
                  "Welcome back,\nLog in",
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
                        controller: _usernameController,
                        onChanged: (text) {
                          setState(() {
                            _isUsernameValid = text.isNotEmpty;
                          });
                        },
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.check,
                            color:
                                _isUsernameValid ? Colors.green : Colors.grey,
                          ),
                          label: const Text(
                            "Username:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText:
                            !_isPasswordVisible, // Use the state variable here
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          label: const Text(
                            "Password:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: _goToForgotPassword,
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 70),
                      GestureDetector(
                        onTap: _login,
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
                              "Log in",
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
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "Register",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.black87,
                              ),
                            )
                          ],
                        ),
                      ),
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
