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

  static Future<Directory> _getSaveDirectory() async {
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      // The documents directory on desktop platforms doesn't actually reflect
      // an application specific directory and instead uses "~/Documents".
      return await getApplicationSupportDirectory();
    }

    return await getApplicationDocumentsDirectory();
  }

  Future<void> loadSaveState() async {
    final directory = await _getSaveDirectory();
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
        saveStateManager: saveStateManager,
      ),
    );
  }
}
