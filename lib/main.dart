// import 'package:flutter/material.dart';
// import 'home_page.dart'; // Import HomePage

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'home_page.dart'; // Import HomePage
import 'quiz_page.dart'; // Import QuizPage
import 'result_page.dart'; // Import ResultPage

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/', // Define initial route
      routes: {
        '/': (context) => HomePage(),
        '/quiz': (context) => QuizPage(),
        '/result': (context) => ResultPage(
          score: 0, // Temporary placeholder
          totalQuestions: 0, // Temporary placeholder
        ),
      },
    );
  }
}