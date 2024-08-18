import 'package:flutter/material.dart';
import 'quiz_page.dart'; // Ensure this import is correct

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Quiz Time',
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(185, 50),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              child: Text(
                'Start',
                style: TextStyle(
                  fontSize: 30, 
                  color: Colors.black, // Text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
