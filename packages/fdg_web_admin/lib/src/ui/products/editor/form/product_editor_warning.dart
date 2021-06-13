import 'package:flutter/material.dart';

class ProductEditorWarning extends StatelessWidget {
  final Color color;
  final Widget icon;
  final Widget label;

  const ProductEditorWarning({
    Key? key,
    required this.color,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Row(
        children: [
          IconTheme(
            data: IconThemeData(
              color: color,
            ),
            child: icon,
          ),
          SizedBox(width: 10),
          DefaultTextStyle(
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
              color: color,
            ),
            child: label,
          )
        ],
      ),
    );
  }
}