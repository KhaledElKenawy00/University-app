import 'package:flutter/material.dart';
import 'package:university/screen/sign_in.dart';
import 'package:university/service/datbase_helper.dart';

class RegisterScreen extends StatefulWidget {
  static const String routName = "/RegisterScreen";
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _departmentIdController = TextEditingController();
  final _lnameController = TextEditingController();
  String _selectedRole = "Student";

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        final db = DatabaseHelper.instance;
        Map<String, dynamic> data = {
          "first_name": _nameController.text,
          "last_name": _lnameController.text,
          "email": _emailController.text,
          "password": _passwordController.text,
          "phone": _phoneController.text,
          "department_id": _departmentIdController.text
        };

        await db.insert(_selectedRole, data);

        print("+++++++++++++++++++++++++${data}");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$_selectedRole Registered Successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Register Page',
          style: TextStyle(
            fontSize: 25,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Register a New Account',
                style: TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                items: ["Student", "Professor", "HeadOfDepartment"]
                    .map((role) => DropdownMenuItem(
                          value: role,
                          child: Text(role),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Select Role',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'firstName',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _lnameController,
                decoration: InputDecoration(
                  labelText: 'lastName',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value!.isEmpty ? 'Enter your email' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                obscureText: true,
                validator: (value) => value!.length < 6
                    ? 'Password must be at least 6 characters'
                    : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _departmentIdController,
                decoration: InputDecoration(
                  labelText: 'Department ID',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Enter your department ID' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerUser,
                child: Text('Register as $_selectedRole'),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text("I have an account?"),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => SignInPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(color: Colors.red, fontSize: 25),
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
