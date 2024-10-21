import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stopwatch App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StopwatchHome(),
    );
  }
}

class StopwatchHome extends StatefulWidget {
  @override
  _StopwatchHomeState createState() => _StopwatchHomeState();
}

class _StopwatchHomeState extends State<StopwatchHome> {
  late Stopwatch _stopwatch;
  late Timer _timer;
  String _formattedTime = "00:00:00";

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  void _startStopwatch() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        setState(() {
          _formattedTime = _formatTime(_stopwatch.elapsedMilliseconds);
        });
      });
    }
  }

  void _stopStopwatch() {
    _stopwatch.stop();
    _timer.cancel();
    setState(() {
      _formattedTime = _formatTime(_stopwatch.elapsedMilliseconds);
    });
  }

  void _resetStopwatch() {
    _stopwatch.reset();
    setState(() {
      _formattedTime = "00:00:00";
    });
  }

  String _formatTime(int milliseconds) {
    int hours = (milliseconds ~/ 3600000) % 24;
    int minutes = (milliseconds ~/ 60000) % 60;
    int seconds = (milliseconds ~/ 1000) % 60;
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Center(child: const Text('StopWatch', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formattedTime,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _startStopwatch,
                  child: const Text('Start'),
                ),
                ElevatedButton(
                  onPressed: _stopStopwatch,
                  child: const Text('Hold'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _stopStopwatch();
                    _resetStopwatch();
                  },
                  child: const Text('Stop'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
