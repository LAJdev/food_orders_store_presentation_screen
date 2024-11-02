import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'uiprovider.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({
    required this.duration,
    super.key,
  });

  final Duration duration;

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    animation =
        Tween<double>(begin: widget.duration.inSeconds.toDouble(), end: 0)
            .animate(controller)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            setState(() {
              if (status == AnimationStatus.completed) {
              } else if (status == AnimationStatus.dismissed) {}
            });
          });
    controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UiProvider>(builder: (context, uiprovider, child) {
      var fullHdRatio = uiprovider.fullHdRatio.fullHdRatio;
      return Row(
        children: [
          Text(
            "⏳: ${animation.value.floor().toString()}",
            style: TextStyle(
              fontSize: 10 * fullHdRatio,
              color: animation.value >= 120
                  ? Colors.green
                  : (animation.value >= 60 && animation.value < 120
                      ? Colors.orange
                      : Colors.red),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    });
  }
}
