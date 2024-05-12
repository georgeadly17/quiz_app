import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz_app/compnents/options.dart';
import './completed.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  int amount;
  int category;
  String difficulty;
    HomePage({super.key, required this.amount, required this.category, required this.difficulty});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String? selectedOption; // Track selected option

  void handleOptionSelected(String option) {
    setState(() {
      selectedOption = option; // Update selected option
    });
  }

  List responseData=[];
  int wrongAnswers = 0;
  int rightAnswers = 0;
  int number = 0;
  List<String> shuffledOptions = [];
  late Timer _timer;
  int _secondRemaining = 15;


  Future api()async{
    final response = await http.get(Uri.parse('https://opentdb.com/api.php?amount=${widget.amount}&category=${widget.category}&difficulty=${widget.difficulty}&type=multiple'));
    if(response.statusCode==200){
      var data = jsonDecode(response.body)['results'];
      setState(() {
        responseData = data;
        updateShuffleOption();
      });

    }
  }
  @override
  void initState() {
    super.initState();
    api();
    startTimer();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 421,
                width: 400,
                child: Stack(
                  children: [
                    Container(
                      height: 240,
                      width: 390,
                      decoration: BoxDecoration(
                          color: const Color(0xffA42fc1),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    Positioned(
                      bottom: 60,
                      left: 22,
                      child: Container(
                        height: 170,
                        width: 350,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 1),
                                blurRadius: 5,
                                spreadRadius: 3,
                                color: const Color(0xffA42fc1).withOpacity(0.4))
                          ],
                        ),
                        child:  Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: Column(
                            children: [
                                 Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    rightAnswers.toString(),
                                    style: const TextStyle(
                                        color: Colors.green, fontSize: 20),
                                  ),
                                  Text(
                                    wrongAnswers.toString(),
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 20),
                                  ),
                                ],
                              ),
                                 Center(
                                child: Text(
                                  "Question ${number+1}",
                                  style: const TextStyle(color: Color(0xffA42fc1)),
                                ),
                              ),
                              const   SizedBox(
                                height: 25,
                              ),
                              Text(responseData.isNotEmpty? responseData[number]['question']:'')
                            ],
                          ),
                        ),
                      ),
                    ),
                     Positioned(
                      bottom: 210,
                      left: 140,
                      child: CircleAvatar(
                        radius: 42,
                        backgroundColor: Colors.white,
                        child: Center(
                          child: Text(
                            _secondRemaining.toString(),
                            style: const TextStyle(
                              color: Color(0xffA42fc1),
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Column(
                children: (responseData.isNotEmpty &&
                    responseData[number]['incorrect_answers'] != null)
                    ? shuffledOptions.map((option) {
                  return Options(
                    option: option.toString(),
                    groupValue: selectedOption ?? '', // Pass the selected option
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value; // Update selected option
                      });
                    },
                  );
                }).toList()
                    : [],
              ),

              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffA42fc1),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      elevation: 10),

                  // Inside ElevatedButton onPressed method
                  onPressed: () {
                    if (number == (widget.amount-1)) {
                      if (selectedOption != null) {
                        if (selectedOption == responseData[number]['correct_answer']){
                          isCorrect();
                          completed();
                        }
                        else {
                          isInCorrect();
                          completed();
                        }
                      }
                      
                    } else {
                      if (selectedOption != null) {
                        if (selectedOption == responseData[number]['correct_answer']){
                          isCorrect();
                        }
                        else {
                          isInCorrect();
                        }
                        // Handle selected option
                        // Do something with selectedOption
                        nextQuestion();
                      } else {
                        // Show an alert or prompt user to select an option
                        // Do nothing until an option is selected
                      }
                    }
                  },

                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Next",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void nextQuestion(){
    if(number==(widget.amount-1)){
      completed();
    }
    setState(() {
      number = number + 1;
      updateShuffleOption();
      _secondRemaining = 15;
    });
  }

  void completed(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Completed(rightAnswers: rightAnswers,wrongAnswers: wrongAnswers, amount: widget.amount,)));
  }

  void updateShuffleOption(){
    setState(() {
      shuffledOptions=shuffleOption(
        [
          responseData[number]['correct_answer'],
          ...(responseData[number]['incorrect_answers'] as List)
        ]
      );
    });
  }


  List<String> shuffleOption(List<String> option){
    List<String> shuffledOptions = List.from(option);
    shuffledOptions.shuffle();
    return shuffledOptions;
  }

  void startTimer(){
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(_secondRemaining > 0) {
          _secondRemaining--;
        }
        else {
          nextQuestion();
          _secondRemaining = 15;
          updateShuffleOption();
        }
      });
    });
  }
void isCorrect(){
    setState(() {
      rightAnswers++;
    });
}
  void isInCorrect(){
    setState(() {
      wrongAnswers++;
    });
  }

}