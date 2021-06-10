import 'package:fdg_ui/src/fdg_theme.dart';
import 'package:flutter/material.dart';

class FDGOptionsDialog<T> extends StatelessWidget {
  static const _maxWidth = 400.0;
  static const _maxHeight = 600.0;

  final List<T> options;
  final T value;
  final String Function(T)? label;

  FDGOptionsDialog({
    required this.options,
    required this.value,
    this.label,
  });

  String _label(BuildContext context, T option) {
    if (label != null) return label!(option);
    return option.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        child: ClipRRect(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: _maxWidth,
              maxHeight: _maxHeight,
            ),
            child: ListView.builder(
              itemCount: options.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final option = options[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: FDGTheme().colors.lightGrey2,
                      ),
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
                                  color: Theme.of(context).primaryColor,
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
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
