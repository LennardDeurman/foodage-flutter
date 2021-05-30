import 'package:fdg_ui/src/dialogs/fdg_dialog.dart';
import 'package:fdg_ui/src/fdg_button.dart';
import 'package:flutter/material.dart';

class FDGAlertDialog<T> extends StatelessWidget {
  final Widget? title;
  final Widget content;
  final String? confirmationButtonText;
  final String? cancelButtonText;
  final bool hasCancelButton;

  FDGAlertDialog({
    required this.content,
    this.title,
    this.confirmationButtonText,
    this.cancelButtonText,
    this.hasCancelButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return FDGDialog(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 20,
        ),
        child: Column(
          children: [
            if (title != null)
              DefaultTextStyle(
                child: title!,
                style: Theme.of(context).textTheme.headline2!,
              ),
            DefaultTextStyle(
              child: content,
              style: Theme.of(context).textTheme.headline2!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FDGPrimaryButton(
                  confirmationButtonText ?? MaterialLocalizations.of(context).okButtonLabel,
                  onTap: (context) => Navigator.pop(
                    context,
                    true,
                  ),
                ),
                if (hasCancelButton)
                  FDGSecondaryButton(
                    cancelButtonText ?? MaterialLocalizations.of(context).cancelButtonLabel,
                    onTap: (context) => Navigator.pop(
                      context,
                      false,
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<bool> show(BuildContext context) => showDialog<bool>(context: context, builder: (context) => this).then(
        (value) => value ?? false,
      );
}
