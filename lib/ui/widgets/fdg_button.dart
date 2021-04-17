import 'package:flutter/material.dart';
import 'package:foodage/ui/extensions.dart';

class FDGButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final TextStyle textStyle;
  final MaterialStateProperty<Color> backgroundColor;
  final WidgetTapCallback onTap;
  final double borderRadius;
  final EdgeInsets padding;

  const FDGButton(
    this.text, {
    @required this.onTap,
    this.borderRadius = 8,
    this.backgroundColor,
    this.textStyle,
    this.icon,
    this.padding
  });

  EdgeInsets get _padding => this.padding ?? EdgeInsets.all(8);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size.zero),
        elevation: MaterialStateProperty.all(0),
        backgroundColor: backgroundColor,
        padding: MaterialStateProperty.all(_padding),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(this.borderRadius)
          )
        )
      ),
      onPressed: () => onTap(context),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: this.icon != null,
              child: this.icon ?? Container(),
            ),
            Text(
              this.text,
              style: this.textStyle,
            )
          ],
        ),
      ),
    );
  }

}
