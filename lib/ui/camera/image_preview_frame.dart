import 'package:flutter/material.dart';

class ImagePreviewFrame extends StatelessWidget {

  final Widget child;

  ImagePreviewFrame ({ required this.child });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    );
  }

}