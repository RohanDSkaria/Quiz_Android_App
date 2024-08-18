import 'package:flutter/material.dart';
import 'home_page.dart';
import 'quiz_page.dart';

class ResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;

  ResultPage({required this.score, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Quiz Ended!",
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              "Your Score: $score / $totalQuestions",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Background color
                foregroundColor: Colors.white, // Text color
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0), // Increase padding
                textStyle: TextStyle(fontSize: 20), // Increase text size
              ),
              child: Text("Home Page"),
            ),
          ],
        ),
      ),
    );
  }
}

