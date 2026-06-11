import 'package:fluid_grid/fluid_grid.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    spacing: 40,
                    runSpacing: 40,
                    children: [Grid1(), Grid2(), Grid3()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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

class Grid2 extends StatelessWidget {
  const Grid2({super.key});

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
                  text: "Example 2: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      "FluidGrid with just outer border and fixed column width of 100",
                ),
              ],
            ),
          ),
          FluidGrid(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.5),
            ),
            columns: [
              FluidColumn(label: Text("column1"), width: 100),
              FluidColumn(label: Text("column2"), width: 100),
              FluidColumn(label: Text("column3"), width: 100),
              FluidColumn(label: Text("column4"), width: 100),
              FluidColumn(label: Text("column5"), width: 100),
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
