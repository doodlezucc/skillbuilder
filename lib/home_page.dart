import 'package:flutter/material.dart';
import 'board/board.dart';

import 'branding.dart';
import 'example_data.dart';
import 'models/board.dart';

class MyHomePage extends StatefulWidget {
  final BoardData data = exampleData;

  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(appName),
      ),
      body: Board(data: widget.data),
    );
  }
}
