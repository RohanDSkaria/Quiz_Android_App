import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with SingleTickerProviderStateMixin {
  List<dynamic> questions = [];
  bool isLoading = true;
  String errorMessage = '';
  int currentQuestionIndex = 0;
  String? selectedOption;
  bool showResult = false;
  bool isCorrect = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300), // Duration for rotation
    );
  }

  Future<void> fetchQuestions() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8080/questions'));
      if (response.statusCode == 200) {
        setState(() {
          questions = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load questions';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  void handleOptionTap(String option) {
    if (!showResult) {
      setState(() {
        selectedOption = option;
      });
    }
  }

  void handleSubmit() {
  if (selectedOption != null && !showResult) {
    setState(() {
      int correctAnswerIndex = questions[currentQuestionIndex]['correctAnswerIndex'] ?? -1;
      int selectedIndex = (questions[currentQuestionIndex]['options'] as List).indexOf(selectedOption!);
      isCorrect = selectedIndex == correctAnswerIndex;
      showResult = true;

      // Start rotation animation for selected option
      _controller.reset();
      _controller.forward();
    });
  }
}

  void nextQuestion() {
    setState(() {
      showResult = false;
      selectedOption = null;
      isCorrect = false;
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress = questions.isEmpty ? 0 : (currentQuestionIndex + 1) / questions.length;

    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage, style: TextStyle(color: Colors.white)))
              : Column(
                  children: [
                    // Progress Bar
                    Container(
                      padding: EdgeInsets.all(16.0),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey[800],
                        color: Colors.blue,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: currentQuestionIndex < questions.length
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Question ${currentQuestionIndex + 1}',
                                    style: TextStyle(fontSize: 24, color: Colors.white),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    questions[currentQuestionIndex]['question'],
                                    style: TextStyle(fontSize: 24, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 20),
                                  // Display Options in 2x2 Grid
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10.0,
                                        mainAxisSpacing: 10.0,
                                        childAspectRatio: 3.0,
                                      ),
                                      itemCount: (questions[currentQuestionIndex]['options'] as List).length,
                                      itemBuilder: (context, index) {
                                        var option = (questions[currentQuestionIndex]['options'] as List)[index];
                                        bool isSelected = option == selectedOption;
                                        int correctAnswerIndex = questions[currentQuestionIndex]['correctAnswerIndex'] ?? -1;
                                        // ignore: unused_local_variable
                                        bool isOptionCorrect = index == correctAnswerIndex;

                                        return GestureDetector(
                                          onTap: () {
                                            handleOptionTap(option);
                                          },
                                          child: AnimatedBuilder(
                                            animation: _controller,
                                            builder: (context, child) {
                                              double rotationAngle = isSelected
                                                  ? (isCorrect ? _controller.value * 6.2832 : _controller.value * 12.5664) // 360 or 720 degrees
                                                  : 0.0;

                                              return Transform(
                                                transform: Matrix4.rotationY(rotationAngle),
                                                alignment: Alignment.center,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? (showResult
                                                            ? (isCorrect ? Colors.green : Colors.red)
                                                            : Colors.purple.shade400) // Greyish purple for selected
                                                        : Colors.blue,
                                                    borderRadius: BorderRadius.circular(8.0),
                                                  ),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      handleOptionTap(option);
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.transparent,
                                                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(8.0),
                                                      ),
                                                    ),
                                                    child: isSelected && showResult
                                                        ? Text(
                                                            isCorrect ? "Correct!" : "Wrong!",
                                                            style: TextStyle(color: Colors.white, fontSize: 33),
                                                          )
                                                        : Text(
                                                            option,
                                                            style: TextStyle(color: Colors.black, fontSize: 37),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      }
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  // Submit and Next Buttons Side by Side
                                  if (!showResult)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: handleSubmit,
                                          child: Text("Submit"),
                                        ),
                                        SizedBox(width: 20),
                                        ElevatedButton(
                                          onPressed: () {
                                            if (showResult) {
                                              nextQuestion();
                                            }
                                          },
                                          child: Text(currentQuestionIndex < questions.length - 1
                                              ? 'Next Question'
                                              : 'Finish Quiz'),
                                        ),
                                      ],
                                    ),
                                  // Result Display and Next Button
                                  if (showResult)
                                    Column(
                                      children: [
                                        Text(
                                          isCorrect ? 'Correct! Good job!' : 'Incorrect. The correct answer was ${questions[currentQuestionIndex]['correctAnswer']}.',
                                          style: TextStyle(
                                            color: isCorrect ? Colors.green : Colors.red,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 20),
                                        ElevatedButton(
                                          onPressed: nextQuestion,
                                          child: Text(currentQuestionIndex < questions.length - 1
                                              ? 'Next Question'
                                              : 'Finish Quiz'),
                                        ),
                                      ],
                                    ),
                                ],
                              )
                            : Center(child: Text('Quiz Complete!', style: TextStyle(color: Colors.white))),
                      ),
                    ),
                  ],
                ),
    );
  }
}
