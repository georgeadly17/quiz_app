import 'package:flutter/material.dart';
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
        title: Text('Choose Quiz Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200, // Adjust width as needed
              height: 200, // Adjust height as needed
              child: Image.asset("assets/image/quiz.png"),
            ),
            SizedBox(height: 16),
            _buildDropDownWithTitle(
              'Amount of Questions',
              DropdownButton<int>(
                hint: Text('Select Amount of Questions'),
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
            SizedBox(height: 20),
            _buildDropDownWithTitle(
              'Category',
              DropdownButton<int>(
                hint: Text('Select Category'),
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
            SizedBox(height: 20),
            _buildDropDownWithTitle(
              'Difficulty',
              DropdownButton<String>(
                hint: Text('Select Difficulty'),
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
            SizedBox(height: 20),
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
                } else {
                  // Handle invalid category selection
                  // Show an alert or prompt the user to select a valid category
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Color(0xffA42fc1), // Color for the button
              ),
              child: Text(
                'Start',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropDownWithTitle(String title, Widget dropdown) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 3,
              color: Color(0xffA42fc1),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: dropdown,
          ),
        ),
      ],
    );
  }
}