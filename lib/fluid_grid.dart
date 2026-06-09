import 'dart:math';
import 'package:flutter/material.dart';

class FluidGrid extends StatefulWidget {
  const FluidGrid({
    super.key,
    this.headerHeight = _Constants.defaultCellHeight,
    this.headerColor,
    this.isBorderEnabled = false,
    this.decoration,
    required this.columns,
    required this.rows,
    this.scrollController,
    this.onEndReached,
  });

  final double headerHeight;
  final Color? headerColor;
  final bool isBorderEnabled;
  final BoxDecoration? decoration;
  final List<FluidColumn> columns;
  final List<FluidRow> rows;
  final ScrollController? scrollController;
  final VoidCallback? onEndReached;
  @override
  State<FluidGrid> createState() => _FluidGridState();
}

class _FluidGridState extends State<FluidGrid> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = widget.scrollController ?? ScrollController();
    scrollController.addListener(_scrollListener);
    _isBorderUniform();
  }

  // Listener to detect when the user has scrolled to the end of the table, this is useful for implementing infinite scrolling or loading more data when the user reaches the end of the table
  void _scrollListener() {

    if (scrollController.position.atEdge && scrollController.position.pixels > 0) {
      widget.onEndReached?.call();
    }
  }

  //check if the border is uniform, if not throw an exception, this is to ensure that the table looks consistent and does not have different border widths on different sides
  void _isBorderUniform() {
    if (widget.decoration?.border == null) {
      return;
    }

    if (widget.decoration?.border is Border) {
      final Border border = widget.decoration!.border as Border;
      final bool isUniform =
          border.top == border.bottom &&
          border.top == border.left &&
          border.top == border.right;

      if (!isUniform) {
        throw Exception("The border is not uniform.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final height = _calculateHeight(constraints: constraints);
          final width = _calculateWidth(constraints: constraints);

          return Container(
            clipBehavior: Clip.hardEdge,
            height: height,
            decoration:
                widget.decoration?.copyWith(
                  border: widget.isBorderEnabled ? widget.decoration?.border : null,
                  color: widget.decoration?.color ?? _Constants.defaultColor,
                ) ??
                BoxDecoration(border: widget.isBorderEnabled ? Border.all() : null),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: width,
                child: Column(
                  children: [
                    _buildColumns(),
                    Flexible(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        scrollDirection: Axis.vertical,
                        child: _buildRows(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildColumns() {
    return Container(
      color: widget.headerColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            widget.columns.asMap().entries.map((entry) {
              final column = entry.value;

              final container = Container(
                width: column.width,
                height: widget.headerHeight,
                alignment: column.alignment,
                padding: column.padding,
                decoration: column.decoration,
                child: column.label,
              );

              if (column.width == null) {
                return Expanded(child: container);
              }

              return container;
            }).toList(),
      ),
    );
  }

  Widget _buildRows() {
    return Column(
      children:
          widget.rows.asMap().entries.map((entries) {
            final row = entries.value;
            final rowIndex = entries.key;
            return Column(
              children: [
                if (widget.isBorderEnabled) _getHorizontalBorder(),
                Container(
                  color: row.color,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                        row.cells.asMap().entries.map((entry) {
                          return _buildCell(
                            entry: entry,
                            rowIndex: rowIndex,
                            height: row.height,
                          );
                        }).toList(),
                  ),
                ),
              ],
            );
          }).toList(),
    );
  }

  // Utility method to get the horizontal border widget, this is used to draw the border between the rows if the border is enabled
  Widget _getHorizontalBorder() {
    if (!widget.isBorderEnabled) {
      return SizedBox.shrink();
    }

    Color? color = widget.decoration?.border?.top.color;
    double thickness = widget.decoration?.border?.top.width ?? 1;

    return Container(
      width: double.infinity,
      height: thickness,
      color: color ?? Colors.black,
    );
  }

  //utility method to calculate the minimum width of the table based on the column widths

  double _calculateWidth({required BoxConstraints constraints}) {
    return max(
      _calculateMinWidth(),
      constraints.maxWidth -
          (widget.isBorderEnabled || widget.decoration?.border != null
              ? _getHorizontalBorderWidth()
              : 0),
    );
  }

  double _calculateHeight({required BoxConstraints constraints}) {
    return min(_calculateMinHeight(), constraints.maxHeight);
  }

  double _calculateMinWidth() {
    double minWidth = 0;
    for (var column in widget.columns) {
      minWidth += column.width ?? _Constants.defaultCellWidth;
    }
    return minWidth;
  }

  double _calculateMinHeight() {
    double minHeight =
        widget.headerHeight +
        (widget.isBorderEnabled || widget.decoration?.border != null
            ? _getVerticalBorderWidth()
            : 0);
    for (var row in widget.rows) {
      minHeight += row.height;
    }
    return minHeight;
  }

  double _getHorizontalBorderWidth() {
    if (!widget.isBorderEnabled && widget.decoration?.border == null) {
      return 0;
    } else if (widget.decoration?.border == null) {
      return 2;
    }

    final BoxBorder? boxBorder = widget.decoration?.border;

    double horizontalThickness = 0;

    if (boxBorder is Border) {
      horizontalThickness = boxBorder.left.width + boxBorder.right.width;
    }

    return horizontalThickness;
  }

  double _getVerticalBorderWidth() {
    if (!widget.isBorderEnabled && widget.decoration?.border == null) {
      return 0;
    } else if (widget.decoration?.border == null) {
      return widget.rows.length + 2;
    }

    final BoxBorder? boxBorder = widget.decoration?.border;
    double verticalThickness = widget.rows.length.toDouble();

    if (boxBorder is Border) {
      verticalThickness = boxBorder.top.width;
    }

    double internalVerticalThickness =
        widget.isBorderEnabled ? widget.rows.length.toDouble() : 0;

    verticalThickness = (internalVerticalThickness + 2) * verticalThickness;

    return verticalThickness;
  }

  //abstracted widget to build a cell, can be used for both header and body cells
  Widget _buildCell({
    required MapEntry<int, DataCellCustom> entry,
    required int rowIndex,
    double? height,
  }) {
    final cell = entry.value;
    final index = entry.key;
    final column = widget.columns[index];

    final double? width =
        cell.expanded ? null : column.width ?? _Constants.defaultCellWidth;
    final padding = cell.padding ?? column.padding;
    final alignment = cell.alignment ?? column.alignment;
    final bool isExpanded = cell.expanded || column.width == null;

    final Container cellContainer = Container(
      width: width,
      height: height ?? _Constants.defaultCellHeight,
      decoration: cell.decoration,
      alignment: alignment,
      padding: padding,
      child: cell.child,
    );

    if (isExpanded) {
      return Expanded(child: cellContainer);
    }

    return cellContainer;
  }
}

// Custom classes to represent the structure of the DataTable

class FluidColumn {
  final Widget label;
  final double? width;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry? padding;
  final BoxDecoration? decoration;

  const FluidColumn({
    required this.label,
    this.width,
    this.alignment = Alignment.center,
    this.padding,
    this.decoration,
  }) : super();
}

class FluidRow {
  final List<DataCellCustom> cells;
  final double height;
  final Color? color;

  const FluidRow({
    required this.cells,
    this.height = _Constants.defaultCellHeight,
    this.color,
  });
}

class DataCellCustom {
  final Widget child;
  final bool expanded;
  final BoxDecoration? decoration;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;

  const DataCellCustom({
    required this.child,
    this.expanded = false,
    this.decoration,
    this.alignment,
    this.padding,
  });
}

// Singleton class to hold constants for the DataTable
class _Constants {
  static const double defaultCellWidth = 0;
  static const double defaultCellHeight = 40;
  static const Color defaultColor = Colors.white;

  static final _Constants _instance = _Constants._internal();

  _Constants._internal();

  factory _Constants() {
    return _instance;
  }
}
