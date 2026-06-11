import 'package:fluid_grid/fluid_grid.dart';
import 'package:flutter/material.dart';

class Grid3 extends StatelessWidget {
  const Grid3({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Example 3: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      "Fully customized FluidGrid with all borders, custom header height and color, fixed column width, custom cell decoration and alignment.",
                ),
              ],
            ),
          ),
          FluidGrid(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            headerHeight: 100,
            isBorderEnabled: true,
            headerColor: Colors.blueGrey,
            columns: [
              FluidColumn(
                label: Text("column1"),
                width: 100,
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(),
              ),
              FluidColumn(
                label: Text("column2"),
                width: 100,
                alignment: Alignment.centerLeft,
              ),
              FluidColumn(label: Text("column3"), width: 100),
              FluidColumn(label: Text("column4"), width: 100),
              FluidColumn(label: Text("column5"), width: 100),
            ],
            rows: [
              FluidRow(
                cells: [
                  FluidDataCell(
                    child: Text("cell1"),
                    decoration: BoxDecoration(color: Colors.yellow),
                  ),
                  FluidDataCell(child: Text("cell2")),
                  FluidDataCell(child: Text("cell3")),
                  FluidDataCell(child: Text("cell4")),
                  FluidDataCell(child: Text("cell5")),
                ],
              ),
              FluidRow(
                cells: [
                  FluidDataCell(child: Text("cell6")),
                  FluidDataCell(
                    child: Text("cell7"),
                    decoration: BoxDecoration(color: Colors.greenAccent),
                  ),
                  FluidDataCell(child: Text("cell8")),
                  FluidDataCell(child: Text("cell9")),
                  FluidDataCell(child: Text("cell10")),
                ],
              ),
              FluidRow(
                cells: [
                  FluidDataCell(child: Text("cell11")),
                  FluidDataCell(child: Text("cell12")),
                  FluidDataCell(child: Text("cell13")),
                  FluidDataCell(child: Text("cell14")),
                  FluidDataCell(child: Text("cell15")),
                ],
              ),
              FluidRow(
                cells: [
                  FluidDataCell(child: Text("cell16")),
                  FluidDataCell(child: Text("cell17")),
                  FluidDataCell(child: Text("cell18")),
                  FluidDataCell(child: Text("cell19")),
                  FluidDataCell(child: Text("cell20")),
                ],
              ),
              FluidRow(
                height: 100,
                cells: [
                  FluidDataCell(
                    child: Text("cell21"),
                    expanded: true,

                    alignment: Alignment.center,
                  ),
                ],
              ),
              FluidRow(
                cells: [FluidDataCell(child: Text("cell22"), expanded: true)],
              ),
              FluidRow(
                cells: [
                  FluidDataCell(
                    child: Text("cell21"),
                    alignment: Alignment.centerLeft,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
