import 'package:flutter/material.dart';
import 'package:university/screen/head_of_department_page.dart';
import 'package:university/screen/professor_page.dart';
import 'package:university/screen/student_page.dart';
import 'package:university/service/datbase_helper.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Function to handle sign-in
  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      // Call the getUserByEmailAndPassword function from DatabaseHelper
      final result = await DatabaseHelper.instance
          .getUserByEmailAndPassword(email, password);

      if (result != null) {
        final userType = result['userType'];
        final userData = result['data'];

        // Handle navigation based on user type
        if (userType == 'Student') {
          // Extract student_id
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Student Sign-in successful!')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => StudentPage(email: email),
            ),
          );
        } else if (userType == 'Professor') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Professor Sign-in successful!')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfessorPage()),
          );
        } else if (userType == 'HeadOfDepartment') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Head of Department Sign-in successful!')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HeadOfDepartmentPage()),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid email or password')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Add your app logo or image here
              Text(
                'Sign In to Your Account',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              // Email Input
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              // Password Input
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Sign In Button
              ElevatedButton(
                onPressed: _signIn,
                child: Text('Sign In'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Option to go to Register Page
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
