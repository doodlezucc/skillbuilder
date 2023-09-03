import 'package:flutter/material.dart';

import 'infinite_canvas.dart';
import 'milestone.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  @override
  Widget build(BuildContext context) {
    return const InfiniteCanvas(
      children: [
        Milestone(
          label: 'w',
          offset: Offset(0, 0),
        ),
        Milestone(
          label: '10x cooking oder so\nepic',
          offset: Offset(250, -50),
        ),
      ],
    );
  }
}
