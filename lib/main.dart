import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _result = "0";
  String _operator = "";
  late double _firstNumber;
  bool _shouldClear = true;

  void _onNumberPressed(String text) {
    if (_result == "0" || _shouldClear) {
      setState(() {
        _result = text;
        _shouldClear = false;
      });
    } else {
      setState(() {
        _result += text;
      });
    }
  }

  void _onOperatorPressed(String text) {
    if (_operator != "") {
      _calculate();
    }

    setState(() {
      _firstNumber = double.parse(_result);
      _result = "0";
      _operator = text;
    });
  }

  void _onClearPressed() {
    setState(() {
      _result = "0";
      _operator = "";
      _firstNumber = 0;
    });
  }

  void _onEqualsPressed() {
    _calculate();
  }

  void _calculate() {
    if (_operator == "+") {
      setState(() {
        _result = (_firstNumber + double.parse(_result)).toString();
        _operator = "";
      });
    } else if (_operator == "-") {
      setState(() {
        _result = (_firstNumber - double.parse(_result)).toString();
        _operator = "";
      });
    } else if (_operator == "x") {
      setState(() {
        _result = (_firstNumber * double.parse(_result)).toString();
        _operator = "";
      });
    } else if (_operator == "÷") {
      setState(() {
        _result = (_firstNumber / double.parse(_result)).toString();
        _operator = "";
      });
    }
    _shouldClear = true;
  }

  @override
  Widget build(BuildContext context) {
    _buildButton(String text, {onPressed}) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(70),
            child: SizedBox(
              height: 100,
              child: ElevatedButton(
                onPressed: onPressed,
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 24.0),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text('Calculator App'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.bottomRight,
                child: Text(
                  _result,
                  style: const TextStyle(fontSize: 48.0),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton("C", onPressed: _onClearPressed),
                _buildButton("÷", onPressed: () => _onOperatorPressed("÷")),
                _buildButton("×", onPressed: () => _onOperatorPressed("×")),
                _buildButton("-", onPressed: () => _onOperatorPressed("-")),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton("7", onPressed: () => _onNumberPressed("7")),
                _buildButton("8", onPressed: () => _onNumberPressed("8")),
                _buildButton("9", onPressed: () => _onNumberPressed("9")),
                _buildButton("+", onPressed: () => _onOperatorPressed("+")),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton("4", onPressed: () => _onNumberPressed("4")),
                _buildButton("5", onPressed: () => _onNumberPressed("5")),
                _buildButton("6", onPressed: () => _onNumberPressed("6")),
                _buildButton("=", onPressed: _onEqualsPressed),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton("1", onPressed: () => _onNumberPressed("1")),
                _buildButton("2", onPressed: () => _onNumberPressed("2")),
                _buildButton("3", onPressed: () => _onNumberPressed("3")),
                _buildButton("0", onPressed: () => _onNumberPressed("0")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
