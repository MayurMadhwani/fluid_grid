import 'package:fluid_grid/fluid_grid.dart';
import 'package:flutter/material.dart';

class Grid1 extends StatelessWidget {
  const Grid1({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Example 1: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: "FluidGrid with just outer border"),
              ],
            ),
          ),
          FluidGrid(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.5),
            ),
            columns: [
              FluidColumn(label: Text("column1")),
              FluidColumn(label: Text("column2")),
              FluidColumn(label: Text("column3")),
              FluidColumn(label: Text("column4")),
              FluidColumn(label: Text("column5")),
            ],
            rows: [
              FluidRow(
                cells: [
                  FluidDataCell(child: Text("cell1")),
                  FluidDataCell(child: Text("cell2")),
                  FluidDataCell(child: Text("cell3")),
                  FluidDataCell(child: Text("cell4")),
                  FluidDataCell(child: Text("cell5")),
                ],
              ),
              FluidRow(
                cells: [
                  FluidDataCell(child: Text("cell6")),
                  FluidDataCell(child: Text("cell7")),
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
                cells: [
                  FluidDataCell(child: Text("cell21")),
                  FluidDataCell(child: Text("cell22")),
                  FluidDataCell(child: Text("cell23")),
                  FluidDataCell(child: Text("cell24")),
                  FluidDataCell(child: Text("cell25")),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
