import 'package:flutter/material.dart';

class FDGRatio extends StatelessWidget {

  static const aspectRatio = 1.25;

  final Widget? child;

  FDGRatio ({ this.child });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: child,
    );
  }

}