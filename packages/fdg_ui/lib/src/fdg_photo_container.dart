import 'package:flutter/material.dart';
import 'package:fdg_common/fdg_common.dart';
import 'package:fdg_ui/fdg_ui.dart';

class FDGPhotoContainer extends StatelessWidget {
  final double borderRadius;
  final Widget content;
  final List<Widget> actionButtons;

  FDGPhotoContainer({
    required this.content,
    required this.actionButtons,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: FDGRatio(
              child: content,
            ),
          ),
        ),
        Positioned(
          top: -5,
          right: 10,
          child: Row(
            children: actionButtons
                .intersperse(
              SizedBox(
                width: 8,
              ),
            )
                .toList(),
          ),
        ),
      ],
    );
  }
}
