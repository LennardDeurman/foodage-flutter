import 'package:flutter/material.dart';
import 'package:foodage/ui/extensions.dart';

class PhotoContainer extends StatelessWidget {

  final double width;
  final double height;
  final WidgetTapCallback onRemovePressed;

  PhotoContainer ({ this.width = 120, this.height = 100, this.onRemovePressed });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      color: Colors.red,
    );
  }

}