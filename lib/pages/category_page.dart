import 'package:flutter/material.dart';
import '../compnents/dropDown.dart';
import 'home_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int? amount;
  int? category;
  String? difficulty;

  List<int> amounts = [10, 20, 30, 40, 50];
  Map<int, String> categories = {
    9: 'General Knowledge',
    18: 'Science: Computers',
    21: 'Sports',
    27: 'Animals',
    23: 'History', // Added History category
  };
  List<String> difficulties = ['easy', 'medium', 'hard'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Quiz Settings',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: const Color(0xffA42fc1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset("assets/image/quiz.png"),
            ),
            const SizedBox(height: 16),
            MyDropDown(
              title: 'Amount of Questions',
              dropdown: DropdownButton<int>(
                hint: const Text('Select Amount of Questions'),
                value: amount,
                onChanged: (value) {
                  setState(() {
                    amount = value;
                  });
                },
                items: amounts.map((amount) {
                  return DropdownMenuItem<int>(
                    value: amount,
                    child: Text('$amount'),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            MyDropDown(
              title: 'Category',
              dropdown: DropdownButton<int>(
                hint: const Text('Select Category'),
                value: category,
                onChanged: (value) {
                  setState(() {
                    category = value;
                    // Handle the selected category
                  });
                },
                items: categories.entries.map((entry) {
                  return DropdownMenuItem<int>(
                    value: entry.key,
                    child: Text(entry.value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            MyDropDown(
              title: 'Difficulty',
              dropdown: DropdownButton<String>(
                hint: const Text('Select Difficulty'),
                value: difficulty,
                onChanged: (value) {
                  setState(() {
                    difficulty = value;
                  });
                },
                items: difficulties.map((difficulty) {
                  return DropdownMenuItem<String>(
                    value: difficulty,
                    child: Text(difficulty),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (category != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        amount: amount!,
                        category: category!,
                        difficulty: difficulty!,
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: const Color(0xffA42fc1),
              ),
              child: const Text(
                'Start',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
