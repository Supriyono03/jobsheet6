import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apa Kabar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> studentNames = [
    'SUPRIYONO',
    'DIPA',
    'ISMAIL',
    'ADE',
    'SETIAWAN',
  ];

  int _currentIndex = 0;
  Color _currentColor = Colors.black;
  int _intervalSeconds = 2;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: _intervalSeconds), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % studentNames.length;
        _currentColor = _getRandomColor();
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  Color _getRandomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  void _incrementInterval() {
    setState(() {
      _intervalSeconds++;
      _startTimer();
    });
  }

  void _decrementInterval() {
    setState(() {
      if (_intervalSeconds > 1) {
        _intervalSeconds--;
        _startTimer();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apa Kabar'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _incrementInterval,
          ),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: _decrementInterval,
          ),
        ],
      ),
      body: Center(
        child: Text(
          studentNames[_currentIndex],
          style: TextStyle(
            fontSize: 32,
            color: _currentColor,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: _startTimer,
              child: Text('Start'),
            ),
            ElevatedButton(
              onPressed: _stopTimer,
              child: Text('Stop'),
            ),
          ],
        ),
      ),
    );
  }
}
