import 'package:flutter/material.dart';
import 'package:foodage/ui/widgets/dialogs/fdg_dialog.dart';

import '../../fdg_theme.dart';

class FDGOptionsDialog<T> extends StatelessWidget {
  final List<T> options;
  final T value;
  final String Function(T)? label;
  final bool dismissAfterUpdate;

  FDGOptionsDialog({
    required this.options,
    required this.value,
    this.label,
    this.dismissAfterUpdate = true,
  });

  String _label(BuildContext context, T option) {
    if (label != null) return label!(option);
    return option.toString();
  }

  @override
  Widget build(BuildContext context) {
    return FDGDialog(
      child: Container(
        margin: EdgeInsets.only(top: 15, bottom: 25),
        constraints: BoxConstraints(maxHeight: 400),
        child: ListView.builder(
          itemCount: options.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final option = options[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(width: 1, color: FDGTheme().colors.lightGrey2),
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              _label(context, option),
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            padding: EdgeInsets.all(20),
                          ),
                        ),
                        Visibility(
                          child: Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.done,
                              size: 24,
                              color: FDGTheme().colors.darkRed,
                            ),
                          ),
                          visible: option == value,
                        )
                      ],
                    ),
                  ),
                  onTap: () => Navigator.pop(
                    context,
                    option,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
