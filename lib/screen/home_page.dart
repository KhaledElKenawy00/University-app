import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Home Page",
            style: TextStyle(
                fontSize: 30,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Colors.pink),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 70,
            width: double.infinity,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(25)),
            child: Center(
              child: Text(
                "Add Student",
                style: TextStyle(
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 70,
            width: double.infinity,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(25)),
            child: Center(
              child: Text(
                "Add Proffessor",
                style: TextStyle(
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 70,
            width: double.infinity,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(25)),
            child: Center(
              child: Text(
                "Add Course",
                style: TextStyle(
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 70,
            width: double.infinity,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(25)),
            child: Center(
              child: Text(
                "Add Department",
                style: TextStyle(
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
