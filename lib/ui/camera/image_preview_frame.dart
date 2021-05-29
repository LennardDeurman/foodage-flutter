import 'package:flutter/material.dart';
import 'package:foodage/ui/fdg_theme.dart';

class ImagePreviewFrame extends StatelessWidget {
  final Widget child;

  ImagePreviewFrame({required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: FDGTheme().colors.grey,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: FittedBox(
                child: child,
                fit: BoxFit.contain,
              ),
            ),
          ),
        )
      ],
    );
  }
}
