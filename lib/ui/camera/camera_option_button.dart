import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CameraOptionButton extends StatelessWidget {
  final IconData icon;
  final Function? onTapCallback;
  final bool isEnabled;
  const CameraOptionButton({
    Key? key,
    required this.icon,
    this.onTapCallback,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: SizedBox.fromSize(
            size: Size.square(48),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24.0,
            ),
          ),
          onTap: () {
            if (onTapCallback != null) {
              // Trigger short vibration
              HapticFeedback.selectionClick();
              onTapCallback!();
            }
          },
        ),
      ),
    );
  }
}
