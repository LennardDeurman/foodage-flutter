import 'package:flutter/material.dart';
import '../fdg_theme.dart';

typedef FDGSegmentWidgetBuilder<T> = Widget Function(BuildContext context, T segment);

typedef FDGSegmentThemeBuilder = ThemeData Function(ThemeData localTheme);

class FDGSegmentItem {

  final  WidgetBuilder iconBuilder;
  final FDGSegmentWidgetBuilder<FDGSegmentItem> builder;
  final  String title;

  FDGSegmentItem (this.title, { this.iconBuilder, this.builder });

}

class FDGSegmentedControl<T> extends StatelessWidget {


  ThemeData _unActiveSegmentThemeBuilder(ThemeData localThemeData) {
    final themeData = localThemeData.copyWith(
        primaryColor: FDGTheme().colors.lightGrey2,
        textTheme: localThemeData.textTheme.copyWith(
            button: localThemeData.textTheme.button.copyWith(
                color: FDGTheme().colors.grey
            )
        )
    );
    if (this.unActiveSegmentThemeBuilder != null) return this.unActiveSegmentThemeBuilder(themeData);
    return themeData;
  }

  final List<T> segments;
  final T value;
  final FDGSegmentWidgetBuilder<T> segmentWidgetBuilder;
  final FDGSegmentThemeBuilder unActiveSegmentThemeBuilder;

  FDGSegmentedControl({
    @required this.segments,
    @required this.value,
    @required this.segmentWidgetBuilder,
    this.unActiveSegmentThemeBuilder,
  });


  @override
  Widget build(BuildContext context) {
    final currentThemeData = Theme.of(context);
    final elevatedButtonStyle = (currentThemeData.elevatedButtonTheme.style ?? ButtonStyle()).copyWith(
        padding: MaterialStateProperty.all(EdgeInsets.all(0)),
        minimumSize: MaterialStateProperty.all(Size.zero)
    );
    final outlinedButtonStyle = (currentThemeData.outlinedButtonTheme.style ?? ButtonStyle()).copyWith(
        padding: MaterialStateProperty.all(EdgeInsets.all(0)),
        minimumSize: MaterialStateProperty.all(Size.zero)
    );
    final localThemeData = currentThemeData.copyWith(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: elevatedButtonStyle,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: outlinedButtonStyle,
      ),
    );

    return Theme(
      data: localThemeData,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: () {
          return this.segments.map((segment) {
            if (value == segment) {
              return segmentWidgetBuilder(context, segment);
            }
            return Theme(
              data: _unActiveSegmentThemeBuilder(localThemeData),
              child: Builder(
                builder: (BuildContext context) => segmentWidgetBuilder(context, segment),
              ),
            );
          }).toList();
        }(),
      )
    );
  }

}