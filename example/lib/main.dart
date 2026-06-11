import 'package:flutter/material.dart';
import 'package:fluid_grid/fluid_grid.dart';

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  children: [
                    SizedBox(
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
                                TextSpan(
                                  text: "FluidGrid with just outer border",
                                ),
                              ],
                            ),
                          ),
                          FluidGrid(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 0.5,
                              ),
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
