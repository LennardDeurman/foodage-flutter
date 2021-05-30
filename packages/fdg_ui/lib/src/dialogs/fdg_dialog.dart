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
        children: [
          Positioned(
            bottom: -10,
            right: 30,
            child: FDGBadgeActionButton(
              color: Theme.of(context).primaryColor,
              icon: Icon(Icons.close),
              onPressed: (context) => Navigator.pop(
                context,
                false,
              ),
            ),
          ),
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}
