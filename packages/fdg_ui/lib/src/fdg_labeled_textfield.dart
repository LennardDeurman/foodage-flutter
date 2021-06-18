import 'package:flutter/material.dart';

class FDGLabeledTextField extends StatelessWidget {
  final Widget label;
  final Widget textField;
  final double spacing;

  const FDGLabeledTextField({
    required this.label,
    required this.textField,
    this.spacing = 15,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DefaultTextStyle(
            style: Theme.of(context).textTheme.subtitle2!,
            child: label,
          ),
          SizedBox(
            height: spacing,
          ),
          textField,
        ]
    );
  }
}