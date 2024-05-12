import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  final String option;
  final String groupValue;
  final ValueChanged<String> onChanged;

  Options({
    Key? key,
    required this.option,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          onChanged(option);
        },
        child: Container(
          height: 48,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 3,
              color: const Color(0xffA42fc1),
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      option,
                      overflow: TextOverflow.ellipsis, // Handle text overflow
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Radio(
                    value: option,
                    groupValue: groupValue,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}