import 'package:flutter/material.dart';

class FDGRatio extends StatelessWidget {

  final Widget child;

  const FDGRatio ({ this.child });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.25,
      child: child,
    );
  }

}