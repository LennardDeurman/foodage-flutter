import 'package:flutter/material.dart';

import '../fdg_theme.dart';

class _LabelsBuilder {
  Widget title(BuildContext context, String text, {EdgeInsets? padding}) {
    return Padding(
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.headline2!,
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
      padding: padding ?? EdgeInsets.only(top: 20),
    );
  }

  Widget subtitle(BuildContext context, String text, {EdgeInsets? padding}) {
    return Padding(
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.subtitle1!,
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
      padding: padding ?? EdgeInsets.only(top: 10),
    );
  }
}

class BackgroundBuilder {
  final _LabelsBuilder labels = _LabelsBuilder();

  Widget loading({
    Widget? title,
    Widget? subtitle,
  }) {
    return custom(
      primary: SizedBox.fromSize(
        size: Size.square(40),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            FDGTheme().colors.darkRed,
          ),
        ),
      ),
      title: title,
      subtitle: subtitle,
    );
  }

  Widget failed({
    Widget? title,
    Widget? subtitle,
  }) {
    return custom(
      primary: Icon(
        Icons.warning_rounded,
        color: FDGTheme().colors.darkRed,
        size: 48,
      ),
      title: title,
      subtitle: subtitle,
    );
  }

  Widget custom({
    Widget? primary,
    Widget? title,
    Widget? subtitle,
  }) {
    return Padding(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (primary != null) primary,
          if (title != null) title,
          if (subtitle != null) subtitle,
        ],
      ),
      padding: EdgeInsets.all(20),
    );
  }
}
