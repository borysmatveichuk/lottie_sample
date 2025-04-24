import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lottie Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Lottie Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late final AnimationController _controller;
  static const List<String> _lottieFiles = [
    'assets/lottie/fog.json',
    'assets/lottie/hurricane.json',
    'assets/lottie/thunder-storm.json',
    'assets/lottie/tornado.json',
    'assets/lottie/windy.json',
  ];

  final _random = Random();
  late int _currentLottieFileIdx;

  @override
  void initState() {
    super.initState();

    _currentLottieFileIdx = _random.nextInt(_lottieFiles.length);

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          spacing: 32,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.asset(
              _lottieFiles[_currentLottieFileIdx],
              controller: _controller,
            ),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
                foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _controller.isAnimating ? 'STOP' : 'START',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              onPressed: () {
                if (_controller.isAnimating) {
                  _controller.stop(canceled: true);
                } else {
                  setState(() {
                    _currentLottieFileIdx = _random.nextInt(_lottieFiles.length);
                  });

                  _controller.repeat();
                }
              },
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
