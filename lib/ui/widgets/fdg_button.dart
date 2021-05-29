import 'package:flutter/material.dart';
import 'package:foodage/ui/widget_tap_callback.dart';

//TODO: Refactor this class

enum _ButtonType { elevatedButton, outlineButton }

class _FDGButton extends StatelessWidget {
  final String text;
  final _ButtonType buttonType;
  final WidgetTapCallback onTap;
  final EdgeInsets? textPadding;
  final Widget? icon;

  _FDGButton(
    this.text, {
    required this.onTap,
    required this.buttonType,
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
  final EdgeInsets? padding;
  final double? borderRadius;
  final String text;
  final Widget? icon;
  final WidgetTapCallback onTap;
  final EdgeInsets? textPadding;
  final ButtonStyle? buttonStyle;

  _FDGCustomButton(
    this.text, {
    required this.onTap,
    this.icon,
    this.padding,
    this.textPadding,
    this.borderRadius,
    this.buttonStyle,
  });

  ButtonStyle _getCurrentButtonStyle(ThemeData contextThemeData) {
    if (buttonStyle != null) return buttonStyle!;
    return (buttonType == _ButtonType.elevatedButton
            ? contextThemeData.elevatedButtonTheme.style
            : contextThemeData.outlinedButtonTheme.style) ??
        ButtonStyle();
  }

  ButtonStyle customButtonStyle(
    ThemeData contextThemeData, {
    required Color backgroundColor,
    Color? borderColor,
  }) {
    final borderSide = BorderSide(
      color: borderColor ?? Colors.transparent,
      width: 1,
    );

    final currentButtonStyle = _getCurrentButtonStyle(contextThemeData);

    final updatedButtonStyle = currentButtonStyle.copyWith(
      backgroundColor: currentButtonStyle.backgroundColor ?? MaterialStateProperty.all(backgroundColor),
      elevation: currentButtonStyle.elevation ?? MaterialStateProperty.all(0),
      padding: currentButtonStyle.padding ?? MaterialStateProperty.all(
        padding ?? EdgeInsets.all(8),
      ),
      side: currentButtonStyle.side ?? MaterialStateProperty.all(borderSide),
      shape: currentButtonStyle.shape ?? MaterialStateProperty.all(
        RoundedRectangleBorder(
          side: borderSide,
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
        ),
      ),
    );

    return updatedButtonStyle;
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
    required WidgetTapCallback onTap,
    Widget? icon,
    EdgeInsets? padding,
    EdgeInsets? textPadding,
    double? borderRadius,
    ButtonStyle? buttonStyle,
  }) : super(text,
            onTap: onTap,
            icon: icon,
            padding: padding,
            textPadding: textPadding,
            borderRadius: borderRadius,
            buttonStyle: buttonStyle);

  @override
  ThemeData getLocalThemeData(ThemeData contextThemeData) {
    return contextThemeData.copyWith(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: customButtonStyle(
          contextThemeData,
          backgroundColor: contextThemeData.primaryColor,
        ),
      ),
    );
  }
}

class FDGSecondaryButton extends _FDGCustomButton {
  FDGSecondaryButton(
    String text, {
    required WidgetTapCallback onTap,
    Widget? icon,
    EdgeInsets? padding,
    EdgeInsets? textPadding,
    double? borderRadius,
    ButtonStyle? buttonStyle,
  }) : super(
          text,
          onTap: onTap,
          icon: icon,
          padding: padding,
          textPadding: textPadding,
          borderRadius: borderRadius,
          buttonStyle: buttonStyle,
        );

  @override
  _ButtonType get buttonType => _ButtonType.outlineButton;

  @override
  ThemeData getLocalThemeData(ThemeData contextThemeData) {
    return ThemeData(
      textTheme: contextThemeData.textTheme.copyWith(
        button: contextThemeData.textTheme.button!.copyWith(
          color: contextThemeData.primaryColor,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: customButtonStyle(
          contextThemeData,
          backgroundColor: Colors.transparent,
          borderColor: contextThemeData.primaryColor,
        ),
      ),
    );
  }
}
