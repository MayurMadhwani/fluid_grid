import 'dart:math';
import 'package:flutter/material.dart';

/// Main widget for the FluidGrid, this is the entry point for using the FluidGrid in a Flutter application. It takes in various parameters to customize the appearance and behavior of the grid, such as header height, header color, border options, and the data to be displayed in the columns and rows.
class FluidGrid extends StatefulWidget {

  /// Constructor for the FluidGrid widget, this allows for creating instances of FluidGrid with the specified properties such as header height, header color, border options, decoration, columns, rows, scroll controller, and end reached callback
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

  /// The height of the header row, this allows for controlling the vertical spacing of the header row in the table, providing a way to create more compact or more spaced out layouts based on the content and design requirements
  final double headerHeight;
  /// The color of the header row, this allows for styling options such as background color for the header row
  final Color? headerColor;
  /// If true, a border will be drawn around the table and between the rows, this is useful for creating a more defined grid layout where the boundaries between cells are clearly visible
  final bool isBorderEnabled;
  /// Custom decoration for the entire grid, this allows for styling options such as background color, borders, and shadows for the entire grid, providing more control over the overall appearance of the table
  final BoxDecoration? decoration;
  /// The list of columns in the table, this allows for defining the structure and layout of the table's header, providing flexibility in how the header is displayed and styled
  final List<FluidColumn> columns;
  /// The list of rows in the table, this allows for defining the content and layout of the table's body, providing flexibility in how the data is displayed and styled in each row
  final List<FluidRow> rows;
  /// The list of rows in the table, this allows for defining the content and layout of the table's body, providing flexibility in how the data is displayed and styled in each row
  final ScrollController? scrollController;
  /// Callback that is called when the user scrolls to the end of the table, this is useful for implementing infinite scrolling or loading more data when the user reaches the end of the table
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
    required MapEntry<int, FluidDataCell> entry,
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

/// Custom classes to represent the structure of the DataTable
class FluidColumn {
  /// The header label for the column, this is the text or widget that will be displayed in the header row of the table for this column
  final Widget label;
  /// The width of the column, if null, the column will expand to fill the available space, this allows for flexible layouts where some columns can take up more space than others based on their content and design requirements
  final double? width;
  /// Alignment of the column header, this allows for controlling the positioning of the header label within the column, such as centering it or aligning it to the left or right
  final AlignmentGeometry alignment;
  /// Padding inside the column header, this allows for controlling the spacing between the header label and the edges of the column header cell, providing more control over the layout and appearance of the header
  final EdgeInsetsGeometry? padding;
  /// Custom decoration for the column header, this allows for styling options such as background color, borders, and shadows on a per-column basis
  final BoxDecoration? decoration;

  /// Constructor for the FluidColumn class, this allows for creating instances of FluidColumn with the specified properties such as label, width, alignment, padding, and decoration
  const FluidColumn({
    required this.label,
    this.width,
    this.alignment = Alignment.center,
    this.padding,
    this.decoration,
  }) : super();
}

/// Custom class to represent a row in the DataTable, this allows for more customization options for each row, such as height, color, and the list of cells in the row
class FluidRow {
  /// The list of cells in the row, this allows for defining the content and layout of each cell in the row, providing flexibility in how the data is displayed in each row of the table
  final List<FluidDataCell> cells;
  /// The height of the row, this allows for controlling the vertical spacing of the rows in the table, providing a way to create more compact or more spaced out layouts based on the content and design requirements
  final double height;
  /// The color of the row, this allows for styling options such as background color on a per-row basis
  final Color? color;
  /// Constructor for the FluidRow class, this allows for creating instances of FluidRow with the specified properties such as cells, height, and color
  const FluidRow({
    required this.cells,
    this.height = _Constants.defaultCellHeight,
    this.color,
  });
}

/// Custom class to represent a cell in the DataTable, this allows for more customization options for each cell, such as expanding to fill available space, custom decoration, alignment, and padding
class FluidDataCell {
  /// The content of the cell, this can be any widget, allowing for a wide range of customization options for the cell's content
  final Widget child;
  /// If true, the cell will expand to fill the available space in the column, this is useful for creating flexible layouts where some cells can take up more space than others based on their content
  final bool expanded;
  /// Custom decoration for the cell, this allows for styling options such as background color, borders, and shadows on a per-cell basis
  final BoxDecoration? decoration;
  /// Alignment of the cell's content, this allows for controlling the positioning of the content within the cell, such as centering it or aligning it to the left or right
  final AlignmentGeometry? alignment;
  /// Padding inside the cell, this allows for controlling the spacing between the cell's content and its borders, providing more control over the layout and appearance of the cell
  final EdgeInsetsGeometry? padding;


  /// Constructor for the FluidDataCell class, this allows for creating instances of FluidDataCell with the specified properties such as child, expanded, decoration, alignment, and padding
  const FluidDataCell({
    required this.child,
    this.expanded = false,// By default, cells do not expand to fill available space, this allows for a more compact layout where cells only take up as much space as their content requires unless explicitly set to expand
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
