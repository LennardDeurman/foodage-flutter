import 'package:flutter/material.dart';

class CameraBarContainer extends StatelessWidget {
  final Widget child;
  final BoxDecoration? decoration;

  const CameraBarContainer({
    required this.child,
    this.decoration,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 20,
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            child,
          ],
        ),
        bottom: true,
        top: false,
      ),
    );
  }
}
