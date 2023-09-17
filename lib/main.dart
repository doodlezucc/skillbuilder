import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'branding.dart';
import 'home_page.dart';
import 'io/save_state.dart';

const saveFileName = 'state.json';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SaveStateManager? saveStateManager;

  @override
  void initState() {
    super.initState();
    loadSaveState();
  }

  Future<void> loadSaveState() async {
    final directory = await getApplicationDocumentsDirectory();
    final saveFile = File(join(directory.path, saveFileName));

    saveStateManager = SaveStateManager(saveFile);
    await saveStateManager!.loadOrUseDefault();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        colorScheme: appColorScheme,
        useMaterial3: true,
      ),
      home: MyHomePage(
        saveState: saveStateManager?.state ?? SaveState.empty,
      ),
    );
  }
}
