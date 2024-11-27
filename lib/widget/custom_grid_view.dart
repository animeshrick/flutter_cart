import 'package:flutter/material.dart';

/// A custom [GridView] widget that allows for flexible configuration
/// of the grid's layout and behavior.
///
/// The [CustomGridView] widget provides a simple and reusable way to
/// create a grid layout with customizable spacing, padding, and scroll
/// behavior. This widget can be used in two ways: directly with a list
/// of children, or using the static [count] constructor for building
/// grid items based on an index.
///
/// ```dart
/// CustomGridView(
///   crossAxisCount: 2,
///   crossAxisSpacing: 10,
///   mainAxisSpacing: 10,
///   children: [
///     Container(color: Colors.red),
///     Container(color: Colors.green),
///   ],
/// );
/// ```
///
/// Alternatively, use the [count] constructor:
///
/// ```dart
/// CustomGridView.count(
///   crossAxisCount: 2,
///   crossAxisSpacing: 10,
///   mainAxisSpacing: 10,
///   itemCount: 20,
///   builder: (context, index) {
///     return Container(color: Colors.blue);
///   },
/// );
/// ```
class CustomGridView extends StatelessWidget {
  /// Creates a [CustomGridView] with the specified parameters.
  ///
  /// The [crossAxisCount], [crossAxisSpacing], [mainAxisSpacing], and [children]
  /// A custom [GridView] widget that allows for flexible configuration
  /// of the grid's layout and behavior.
  ///
  /// The [CustomGridView] widget provides a simple and reusable way to
  /// create a grid layout with customizable spacing, padding, and scroll
  /// behavior. This widget can be used in two ways: directly with a list
  /// of children, or using the static [count] constructor for building
  /// grid items based on an index.
  ///
  /// ```dart
  /// CustomGridView(
  ///   crossAxisCount: 2,
  ///   crossAxisSpacing: 10,
  ///   mainAxisSpacing: 10,
  ///   children: [
  ///     Container(color: Colors.red),
  ///     Container(color: Colors.green),
  ///   ],
  /// );
  /// ```
  const CustomGridView({
    super.key,
    this.controller,
    required this.crossAxisCount,
    this.crossAxisSpacing = 0,
    this.mainAxisSpacing = 0,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    required this.children,
    this.rowCrossAxisAlignment = CrossAxisAlignment.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  });

  /// The [ScrollController] to control the grid's scrolling behavior.
  final ScrollController? controller;

  /// The number of columns in the grid.
  final int crossAxisCount;

  /// The amount of space between columns.
  final double crossAxisSpacing;

  /// The amount of space between rows.
  final double mainAxisSpacing;

  /// The physics to use for the grid's scroll view.
  final ScrollPhysics? physics;

  /// Whether the grid should shrink-wrap its content.
  ///
  /// Defaults to `false`.
  final bool shrinkWrap;

  /// The padding around the grid.
  final EdgeInsetsGeometry? padding;

  /// The widgets to display in the grid.
  final List<Widget> children;

  /// How the children should be aligned in the cross axis within each row.
  ///
  /// Defaults to [CrossAxisAlignment.start].
  final CrossAxisAlignment rowCrossAxisAlignment;

  /// Determines how the keyboard is dismissed during scrolling.
  ///
  /// Defaults to [ScrollViewKeyboardDismissBehavior.manual].
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// Creates a [CustomGridView] with a specified item count and builder function.
  ///
  /// The [crossAxisCount], [crossAxisSpacing], [mainAxisSpacing], [itemCount],
  /// and [builder] parameters must not be null
  /// ```dart
  /// CustomGridView.count(
  ///   crossAxisCount: 2,
  ///   crossAxisSpacing: 10,
  ///   mainAxisSpacing: 10,
  ///   itemCount: 20,
  ///   builder: (context, index) {
  ///     return Container(color: Colors.blue);
  ///   },
  /// );
  /// ```
  static Widget count({
    Key? key,
    ScrollController? controller,
    required int crossAxisCount,
    required double crossAxisSpacing,
    required double mainAxisSpacing,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    required int itemCount,
    required IndexedWidgetBuilder builder,
    CrossAxisAlignment rowCrossAxisAlignment = CrossAxisAlignment.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
  }) {
    return _CustomGridView(
      key: key,
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: crossAxisSpacing,
      mainAxisSpacing: mainAxisSpacing,
      physics: physics,
      shrinkWrap: shrinkWrap,
      controller: controller,
      itemCount: itemCount,
      builder: builder,
      padding: padding,
      rowCrossAxisAlignment: rowCrossAxisAlignment,
      keyboardDismissBehavior: keyboardDismissBehavior,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _CustomGridView(
      key: key,
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: crossAxisSpacing,
      mainAxisSpacing: mainAxisSpacing,
      physics: physics,
      shrinkWrap: shrinkWrap,
      controller: controller,
      itemCount: children.length,
      padding: padding,
      rowCrossAxisAlignment: rowCrossAxisAlignment,
      keyboardDismissBehavior: keyboardDismissBehavior,
      children: children,
    );
  }
}

class _CustomGridView extends StatelessWidget {
  const _CustomGridView({
    super.key,
    this.controller,
    required this.crossAxisCount,
    required this.crossAxisSpacing,
    required this.mainAxisSpacing,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    required this.itemCount,
    this.builder,
    this.children,
    this.rowCrossAxisAlignment = CrossAxisAlignment.center,
    required this.keyboardDismissBehavior,
  }) : assert(children != null || builder != null,
            "Children abd builder both can't be null.");
  final ScrollController? controller;
  final int crossAxisCount;
  final double crossAxisSpacing, mainAxisSpacing;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final int itemCount;
  final List<Widget>? children;
  final IndexedWidgetBuilder? builder;
  final CrossAxisAlignment rowCrossAxisAlignment;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      keyboardDismissBehavior: keyboardDismissBehavior,
      controller: controller,
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding,
      itemCount: (itemCount / crossAxisCount).ceil(),
      itemBuilder: (BuildContext context, int columnIndex) {
        return Row(
          crossAxisAlignment: rowCrossAxisAlignment,
          children: List.generate(
            crossAxisCount * 2 - 1,
            (tempRowIndex) {
              if (tempRowIndex.isEven) {
                int rowIndex = tempRowIndex ~/ 2;
                // return CustomText(
                //   "[Row $rowIndex, Column $columnIndex] = index ${rowIndex + (crossAxisCount * columnIndex)} ",
                //   color: Colors.black,
                // );

                int itemIndex = rowIndex + (crossAxisCount * columnIndex);
                if (itemIndex > itemCount - 1) {
                  return const Expanded(child: SizedBox(width: 0));
                }
                // if ((rowIndex + 1) != crossAxisCount)
                //                             SizedBox(width: crossAxisSpacing)
                return children != null || builder != null
                    ? Expanded(
                        child: children?.elementAt(itemIndex) ??
                            builder!(context, itemIndex),
                      )
                    : ErrorWidget.withDetails(
                        message: "Children abd builder both can't be null.",
                      );
              } else {
                return SizedBox(width: crossAxisSpacing);
              }
            },
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: mainAxisSpacing);
      },
    );
  }
}