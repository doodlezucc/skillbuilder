import 'package:flutter/material.dart';

import 'models/blocks/labeled.dart';

class BlockPage extends StatefulWidget {
  final LabeledData block;

  const BlockPage({super.key, required this.block});

  @override
  State<BlockPage> createState() => _BlockPageState();
}

class _BlockPageState extends State<BlockPage> {
  late final nameController = TextEditingController(text: widget.block.label);

  @override
  void initState() {
    super.initState();
    nameController.addListener(() => widget.block.label = nameController.text);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configure ${widget.block.type.name}'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: nameController,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Name...',
            ),
          ),
        ],
      ),
    );
  }
}
