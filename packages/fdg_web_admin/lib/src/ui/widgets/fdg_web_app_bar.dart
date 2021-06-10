import 'package:flutter/material.dart';

class FDGWebAppBar extends StatelessWidget {
  static const _appBarHeight = 64.0;
  static const _maxInnerWidth = 920.0;

  final Widget child;

  const FDGWebAppBar({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      height: _appBarHeight,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          constraints: BoxConstraints(
            maxWidth: _maxInnerWidth,
          ),
          child: child,
        ),
      ),
    );
  }
}
