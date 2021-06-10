import 'package:fdg_ui/src/fdg_badge_action_button.dart';
import 'package:flutter/material.dart';

class FDGDialog extends StatelessWidget {
  final Widget child;

  FDGDialog({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -12,
            right: 30,
            child: FDGBadgeActionButton(
              color: Theme.of(context).primaryColor,
              icon: Icon(Icons.close),
              size: 25,
              onPressed: (context) => Navigator.pop(
                context
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
