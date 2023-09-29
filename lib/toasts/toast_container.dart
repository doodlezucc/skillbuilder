import 'dart:async';

import 'package:flutter/material.dart';

import 'toast.dart';
import 'toast_controller.dart';
import 'toast_widget.dart';

class ToastContainer extends StatefulWidget {
  final ToastController controller;

  const ToastContainer({super.key, required this.controller});

  @override
  State<ToastContainer> createState() => _ToastContainerState();
}

class _ToastContainerState extends State<ToastContainer>
    with TickerProviderStateMixin {
  static const animationVelocity = 10.0;
  static const fadeInDuration = Duration(milliseconds: 800);
  static const timeout = Duration(milliseconds: 1000);

  late StreamSubscription<Toast> toastSubscription;
  late final animationController = AnimationController(
    vsync: this,
    duration: fadeInDuration,
  );

  Timer? timeoutTimer;
  Toast? currentToast;
  bool isFadingOut = false;
  double get animationValue => animationController.value;

  @override
  void initState() {
    super.initState();
    toastSubscription = widget.controller.stream.listen(onAddToast);
  }

  @override
  void dispose() {
    toastSubscription.cancel();
    super.dispose();
  }

  void onAddToast(Toast toast) {
    print('add toast');
    currentToast = toast;
    isFadingOut = false;
    animationController.reset();
    animationController.fling(velocity: animationVelocity);

    timeoutTimer?.cancel();
    timeoutTimer = Timer(timeout, fadeOutToast);
  }

  void fadeOutToast() {
    isFadingOut = true;
    animationController.fling(velocity: -animationVelocity);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AnimatedBuilder(
          animation: animationController.view,
          builder: (ctx, child) {
            if (currentToast != null) {
              return Opacity(
                opacity: animationValue,
                child: Transform.translate(
                  offset: Offset(0, isFadingOut ? 0 : 8 * (1 - animationValue)),
                  child: ToastWidget(currentToast!),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
