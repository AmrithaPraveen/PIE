import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pie/view/StudentFeedbackPage.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:pie/view/HomePage.dart'; // Import HomePage
import 'package:pie/view/TeacherPointsDashboardPage.dart'; // For Teacher and Parent roles

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _googleSignInMethod() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => HomePage(
              username: googleUser.displayName ?? 'Google User',
              points: 100,
              role: 'Student',
            ),
          ),
        );
      }
    } catch (error) {
      print(error); // Handle error
    }
  }

  Future<void> _appleSignInMethod() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    // Navigate to HomePage on successful Apple sign-in
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => HomePage(
          username: appleCredential.givenName ?? 'Apple User',
          points: 100,
          role: 'Student',
        ),
      ),
    );
  }

  // Navigation method for teacher and parent buttons
  void _navigateToTeacherDashboard() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => TeacherPointsDashboardPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Login Page'),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 60),
              Image.asset(
                'assets/image/pie_logo.png',
                height: 100,
              ),
              SizedBox(height: 20),

              Text(
                'Peer Inclusion Empowerment',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A),
                ),
              ),
              SizedBox(height: 40),

              CupertinoTextField(
                controller: _usernameController,
                placeholder: 'Username',
                padding: EdgeInsets.all(16.0),
                keyboardType: TextInputType.text,
                clearButtonMode: OverlayVisibilityMode.editing,
                decoration: BoxDecoration(
                  color: Color(0xFFF3E5F5), // Light purple background
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 16),
              CupertinoTextField(
                controller: _passwordController,
                placeholder: 'Password',
                padding: EdgeInsets.all(16.0),
                obscureText: true,
                clearButtonMode: OverlayVisibilityMode.editing,
                decoration: BoxDecoration(
                  color: Color(0xFFF3E5F5), // Light purple background
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 10),

              // Forgot Password link
              GestureDetector(
                onTap: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: Text('Forgot Password'),
                        content: Text('You can reset your password via email.'),
                        actions: [
                          CupertinoDialogAction(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Color(0xFF6A1B9A), // Dark purple for the link
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Three buttons for Student, Teacher, and Parent
              Container(
                width: double.infinity,
                height: 50,
                child: CupertinoButton(
                  color: Color(0xFF6A1B9A), // Dark purple button
                  onPressed: () {
                    // Navigate to Student Home Page
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => HomePage(
                          username: _usernameController.text,
                          points: 100,
                          role: 'Student',
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'I am a Student',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),

              Container(
                width: double.infinity,
                height: 50,
                child: CupertinoButton(
                  color: Color(0xFF6A1B9A), // Dark purple button
                  onPressed: _navigateToTeacherDashboard,
                  child: Text(
                    'I am a Teacher',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),

              Container(
                width: double.infinity,
                height: 50,
                child: CupertinoButton(
                  color: Color(0xFF6A1B9A), // Dark purple button
                  onPressed: _navigateToTeacherDashboard,
                  child: Text(
                    'I am a Parent',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              // Real logos for Google and Apple sign-in
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: _googleSignInMethod,
                    child: Image.asset(
                      'assets/image/google_logo.png', // Real Google logo
                      height: 40,
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: _appleSignInMethod,
                    child: Image.asset(
                      'assets/image/apple_logo.png', // Real Apple logo
                      height: 40,
                    ),
                  ),
                ],
              ),

              // "Don't have an account? Sign Up" link
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => StudentFeedbackPage(),
                    ),
                  );
                },
                child: Text(
                  "Don't have an account? Sign Up",
                  style: TextStyle(
                    color: Color(0xFF6A1B9A), // Dark purple for the link
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
