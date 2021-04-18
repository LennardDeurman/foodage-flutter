import 'package:flutter/material.dart';
import 'package:foodage/ui/extensions.dart';

enum _ButtonType {
  elevatedButton,
  outlineButton
}

class _FDGButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final WidgetTapCallback onTap;
  final EdgeInsets textPadding;
  final _ButtonType buttonType;

  const _FDGButton(
    this.text, {
    @required this.onTap,
    this.buttonType,
    this.icon,
    this.textPadding,
  });

  EdgeInsets get _textPadding => this.textPadding ?? EdgeInsets.zero;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: this.icon != null,
            child: this.icon ?? Container(),
          ),
          Container(
            padding: _textPadding,
            child: Text(
              this.text,
              style: Theme.of(context).textTheme.button,
            ),
          ),
        ],
      ),
    );
    if (buttonType == _ButtonType.elevatedButton) {
      return ElevatedButton(
        onPressed: () => onTap(context),
        child: child,
      );
    } else if (buttonType == _ButtonType.outlineButton) {
      return OutlinedButton(
        onPressed: () => onTap(context),
        child: child,
      );
    }
    throw UnimplementedError("The corresponding buttonType is not implemented by the _FDGButton");
  }
}

abstract class _FDGCustomButton extends StatelessWidget {
  final EdgeInsets padding;
  final double borderRadius;
  final String text;
  final Widget icon;
  final WidgetTapCallback onTap;
  final EdgeInsets textPadding;

  _FDGCustomButton(
    this.text, {
    @required this.onTap,
    this.icon,
    this.padding,
    this.textPadding,
    this.borderRadius,
  });

  ButtonStyle customButtonStyle(ThemeData contextThemeData, { Color borderColor, Color backgroundColor }) {
    final borderSide = BorderSide(
      color: borderColor ?? Colors.transparent,
      width: 1,
    );

    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(backgroundColor),
      elevation: MaterialStateProperty.all(0),
      padding: MaterialStateProperty.all(padding ?? EdgeInsets.all(8)),
      side: MaterialStateProperty.all(
        borderSide
      ),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
          side: borderSide,
          borderRadius: BorderRadius.circular(borderRadius ?? 0)
      )),
    );
  }

  _ButtonType get buttonType => _ButtonType.elevatedButton;

  ThemeData getLocalThemeData(ThemeData contextThemeData) {
    return contextThemeData;
  }

  @override
  Widget build(BuildContext context) {
    final contextThemeData = Theme.of(context);
    final localThemeData = getLocalThemeData(contextThemeData);
    return Theme(
      data: localThemeData,
      child: _FDGButton(
        this.text,
        onTap: onTap,
        textPadding: textPadding,
        buttonType: buttonType,
        icon: Builder(
          builder: (BuildContext context) {
            return this.icon ?? Container();
          },
        ),
      ),
    );
  }
}

class FDGPrimaryButton extends _FDGCustomButton {
  FDGPrimaryButton(
    String text, {
    @required WidgetTapCallback onTap,
    Widget icon,
    EdgeInsets padding,
    EdgeInsets textPadding,
    double borderRadius,
  }) : super(
          text,
          onTap: onTap,
          icon: icon,
          padding: padding,
          textPadding: textPadding,
          borderRadius: borderRadius,
        );


  @override
  ThemeData getLocalThemeData(ThemeData contextThemeData) {
    return contextThemeData.copyWith(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: customButtonStyle(
          contextThemeData,
          backgroundColor: contextThemeData.primaryColor
        )
      ),
    );
  }
}

class FDGSecondaryButton extends _FDGCustomButton {
  FDGSecondaryButton(
    String text, {
    @required WidgetTapCallback onTap,
    Widget icon,
    EdgeInsets padding,
    EdgeInsets textPadding,
    double borderRadius,
  }) : super(
          text,
          onTap: onTap,
          icon: icon,
          padding: padding,
          textPadding: textPadding,
          borderRadius: borderRadius,
        );

  @override
  _ButtonType get buttonType => _ButtonType.outlineButton;

  @override
  ThemeData getLocalThemeData(ThemeData contextThemeData) {
    return ThemeData(
      textTheme: contextThemeData.textTheme.copyWith(
        button: contextThemeData.textTheme.button.copyWith(
          color: contextThemeData.primaryColor,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: customButtonStyle(
            contextThemeData,
            backgroundColor:  Colors.transparent,
            borderColor: contextThemeData.primaryColor,
        )
      ),
    );
  }
}
