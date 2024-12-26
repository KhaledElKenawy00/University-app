import 'package:flutter/material.dart';
import 'package:university/screen/head_of_department_page.dart';
import 'package:university/screen/home_page.dart';
import 'package:university/screen/register_page.dart';
import 'package:university/screen/student_page.dart';

void main(List<String> args) {
  runApp(University());
}

class University extends StatelessWidget {
  const University({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterScreen(),
    );
  }
}
