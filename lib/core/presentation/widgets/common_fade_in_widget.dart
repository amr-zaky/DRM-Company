import 'package:flutter/material.dart';

class FadeInWidget extends StatefulWidget {
  const FadeInWidget({Key? key, required this.properties, required this.delay})
      : super(key: key);
  final double delay;
  final Widget properties;

  @override
  State<StatefulWidget> createState() => FadeInWidgetState();
}

class FadeInWidgetState extends State<FadeInWidget>
    with TickerProviderStateMixin {
  late AnimationController? controller;
  late Animation<Offset>? position;
  late Animation<double>? opacity;

  final Tween<double> alphaTween = Tween<double>(begin: 0.0, end: 1.0);

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: position!,
      child: FadeTransition(
        opacity: opacity!,
        child: widget.properties,
      ),
    );
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  void _startAnimation() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    position = Tween<Offset>(
      begin: Offset(widget.delay, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller!, curve: Curves.decelerate));

    opacity = alphaTween.animate(controller!);

    controller!.forward();
  }
}
