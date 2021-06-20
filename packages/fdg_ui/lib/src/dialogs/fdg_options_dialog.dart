import 'package:fdg_ui/fdg_ui.dart';
import 'package:fdg_ui/src/fdg_theme.dart';
import 'package:flutter/material.dart';

class FDGOptionsDialog<T> extends StatelessWidget {
  static const _maxWidth = 400.0;
  static const _maxHeight = 600.0;

  final List<T> options;
  final T? value;
  final String Function(T)? label;
  final Widget? footer;
  final Widget? header;

  FDGOptionsDialog({
    required this.options,
    this.footer,
    this.header,
    this.value,
    this.label,
  });

  String _label(BuildContext context, T option) {
    if (label != null) return label!(option);
    return option.toString();
  }

  Widget _rowContent(BuildContext context, int index) {
    final option = options[index];
    return FDGOptionsItemTile<T>(
      option: option,
      label: (option) => _label(context, option),
      isSelected: option == value,
    );
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
                final isFirstPosition = index == 0;
                final isLastPosition = index == options.length - 1;
                if (isFirstPosition) {
                  return Column(
                    children: [
                      if (header != null) header!,
                      _rowContent(context, index),
                    ],
                  );
                } else if (isLastPosition) {
                  return Column(
                    children: [
                      _rowContent(context, index),
                      if (footer != null) footer!,
                    ],
                  );
                }

                return _rowContent(context, index);
              },
            ),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

class FDGOptionsItemTile<T> extends StatelessWidget {
  static const _spacing = 20.0;
  static const _iconSize = 24.0;

  final String Function(T)? label;
  final T option;
  final bool isSelected;

  const FDGOptionsItemTile({
    this.label,
    required this.option,
    this.isSelected = false,
    Key? key,
  }) : super(key: key);

  String _label(BuildContext context, T option) {
    if (label != null) return label!(option);
    return option.toString();
  }

  @override
  Widget build(BuildContext context) {
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
                    padding: EdgeInsets.all(_spacing),
                  ),
                ),
                Visibility(
                  child: Container(
                    margin: EdgeInsets.only(right: _spacing),
                    child: Icon(
                      Icons.done,
                      size: _iconSize,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  visible: isSelected,
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
  }
}

class FDGOptionsAddTile extends StatefulWidget {
  final String confirmationText;
  final Widget label;
  final Widget? icon;
  final String? hintText;
  final Function(String)? onSubmit;

  const FDGOptionsAddTile({
    required this.label,
    required this.confirmationText,
    required this.onSubmit,
    this.icon,
    this.hintText,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => FDGOptionsAddTileState();
}

class FDGOptionsAddTileState extends State<FDGOptionsAddTile> {
  static const _spacing = 20.0;
  static const _iconSize = 24.0;

  bool _isEditing = false;

  TextEditingController _controller = TextEditingController();

  Widget _cell(
    BuildContext context, {
    required List<Widget> children,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Container(
          child: Row(
            children: children,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (_isEditing) {
      return _cell(context, children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: widget.hintText,
                prefixIcon: SizedBox(
                  width: 60,
                  child: Center(
                    child: RawMaterialButton(
                      constraints: BoxConstraints.tight(
                        Size(24, 24),
                      ),
                      onPressed: () {
                        setState(() {
                          _isEditing = false;
                        });
                      },
                      child: Icon(Icons.arrow_back, color: theme.primaryColor, size: 18),
                      shape: CircleBorder(
                        side: BorderSide(
                          color: theme.primaryColor,
                        ),
                      ),
                      elevation: 0.0,
                    ),
                  ),
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.all(8),
                  child: FDGPrimaryButton(
                    widget.confirmationText,
                    onTap: (context) => widget.onSubmit != null ? widget.onSubmit!(_controller.text) : null,
                  ),
                ),
              ),
            ),
          ),
        ),
      ]);
    } else {
      return _cell(
        context,
        onTap: () {
          setState(() {
            _isEditing = true;
          });
        },
        children: [
          Expanded(
            child: Container(
              child: DefaultTextStyle(
                style: theme.textTheme.headline3!.copyWith(
                  fontStyle: FontStyle.italic,
                  color: FDGTheme().colors.lightGrey1,
                ),
                child: widget.label,
              ),
              padding: EdgeInsets.all(_spacing),
            ),
          ),
          if (widget.icon != null)
            Container(
              margin: EdgeInsets.only(right: _spacing),
              child: IconTheme(
                data: IconThemeData(
                  size: _iconSize,
                  color: theme.primaryColor,
                ),
                child: widget.icon!,
              ),
            ),
        ],
      );
    }
  }
}
