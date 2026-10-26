import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = '0';
  double firstNumber = 0;
  String operation = '';
  bool shouldReset = false;

  void onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        display = '0';
        firstNumber = 0;
        operation = '';
        shouldReset = false;
      } else if (value == '+' || value == '-' || value == '×' || value == '÷') {
        firstNumber = double.tryParse(display) ?? 0;
        operation = value;
        shouldReset = true;
      } else if (value == '=') {
        double secondNumber = double.tryParse(display) ?? 0;
        double result = 0;

        switch (operation) {
          case '+':
            result = firstNumber + secondNumber;
            break;
          case '-':
            result = firstNumber - secondNumber;
            break;
          case '×':
            result = firstNumber * secondNumber;
            break;
          case '÷':
            result = secondNumber != 0 ? firstNumber / secondNumber : 0;
            break;
        }

        display = result.toString();
        if (display.endsWith('.0')) {
          display = display.substring(0, display.length - 2);
        }
        operation = '';
        shouldReset = true;
      } else {
        if (shouldReset || display == '0') {
          display = value;
          shouldReset = false;
        } else {
          display += value;
        }
      }
    });
  }

  Widget buildButton(String text, {Color color = Colors.grey}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => onButtonPressed(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // شاشة العرض
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(24),
                child: Text(
                  display,
                  style: const TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // الأزرار
            Column(
              children: [
                Row(
                  children: [
                    buildButton('C', color: Colors.red),
                    buildButton('÷', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton('7'),
                    buildButton('8'),
                    buildButton('9'),
                    buildButton('×', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton('4'),
                    buildButton('5'),
                    buildButton('6'),
                    buildButton('-', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton('1'),
                    buildButton('2'),
                    buildButton('3'),
                    buildButton('+', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton('0'),
                    buildButton('.'),
                    buildButton('=', color: Colors.green),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}