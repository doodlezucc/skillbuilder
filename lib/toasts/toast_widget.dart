import 'package:flutter/material.dart';

import 'toast.dart';

class ToastWidget extends StatefulWidget {
  final Toast data;

  const ToastWidget(this.data, {super.key});

  @override
  State<ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<ToastWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        margin: const EdgeInsets.all(16),
        constraints: const BoxConstraints(
          minWidth: 50,
        ),
        child: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.grey[350]),
            children: [
              if (widget.data.icon != null) ...[
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    widget.data.icon!,
                    color: Colors.grey[350],
                    size: 16,
                  ),
                ),
                const TextSpan(
                  text: '  |  ',
                ),
              ],
              TextSpan(
                text: widget.data.label,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
