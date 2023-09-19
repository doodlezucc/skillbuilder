import 'package:flutter/material.dart';

import '../models/board.dart';
import '../models/blocks/milestone.dart';
import 'animated_painter.dart';

class Board extends StatefulWidget {
  final BoardContext context;
  BoardData get data => context.board;

  const Board({super.key, required this.context});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  static const Size size = Size(100000, 100000);

  late TransformationController _ctrl;

  @override
  void initState() {
    _ctrl = TransformationController();
    super.initState();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void onDoubleTap(TapDownDetails details) {
    setState(() {
      final position = details.localPosition - size.center(Offset.zero);
      final block = MilestoneData(
        label: 'New Milestone',
        position: position,
      );

      widget.data.addBlock(block);
      widget.context.save();
    });
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      constrained: false,
      boundaryMargin: const EdgeInsets.all(double.infinity),
      transformationController: _ctrl,
      minScale: 0.2,
      child: Transform.translate(
        offset: -size.center(Offset.zero) +
            MediaQuery.of(context).size.center(Offset.zero),
        transformHitTests: true,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedPainter(board: widget.data),
              GestureDetector(
                onDoubleTapDown: onDoubleTap,
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                ),
              ),
              ...widget.data.blocks.map((obj) => obj.toWidget(widget.context)),
            ],
          ),
        ),
      ),
    );
  }
}
