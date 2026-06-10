
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
            children: [
              FluidGrid(
                onEndReached: () {
                  print("End of table reached");
                },
                headerHeight: 50,
                headerColor: Colors.blueAccent,
                isBorderEnabled: true,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.circular(20),
                  // color: Colors.blueAccent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                // columns: [
                //   FluidColumn(label: SizedBox()),
                //   FluidColumn(label: SizedBox()),
                //   FluidColumn(label: SizedBox()),
                //   FluidColumn(label: SizedBox()),
                //   FluidColumn(label: SizedBox()),
                // ],
                columns: [
                  FluidColumn(
                    label: Text("column1"),
                    width: 100,
                    decoration: BoxDecoration(
                      // color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.centerRight,
                  ),
                  FluidColumn(
                    label: Text("column2"),
                    width: 100,
                    padding: EdgeInsets.only(right: 5),
                    alignment: Alignment.centerRight,
                    // decoration: BoxDecoration(color: Colors.orangeAccent),
                  ),
                  FluidColumn(
                    label: Text("column3"),
                    width: 100,
                    padding: EdgeInsets.only(right: 20),
                    // decoration: BoxDecoration(color: Colors.yellow),
                  ),
                  FluidColumn(
                    label: Text("column4"),
                    width: 100,
                    padding: EdgeInsets.only(right: 20),
                    // decoration: BoxDecoration(color: Colors.yellowAccent),
                  ),
                  FluidColumn(
                    label: Text("column5"),
                    width: 100,
                    alignment: Alignment.centerLeft,
                    // decoration: BoxDecoration(color: Colors.orange),
                  ),
                ],
                rows: [
                  FluidRow(
                    height: 100,
                    cells: [
                      FluidDataCell(
                        child: Text("cell1"),
                        // decoration: BoxDecoration(color: Colors.red),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 20),
                        expanded: true,
                      ),
                      // FluidDataCell(
                      //   child: Text("cell2"),
                      //   expanded: true,
                      //   decoration: BoxDecoration(color: Colors.blue),
                      // ),
                      // FluidDataCell(child: Text("cell3")),
                      // FluidDataCell(child: Text("cell4")),
                      // FluidDataCell(child: Text("cell5")),
                    ],
                  ),
                  FluidRow(
                    height: 50,
                    cells: [
                      FluidDataCell(
                        child: Text("cell6"),
                        decoration: BoxDecoration(color: Colors.green),
                      ),
                      FluidDataCell(
                        child: Text("cell7"),
                        decoration: BoxDecoration(color: Colors.grey),
                        padding: EdgeInsets.only(right: 20),
                      ),
                      FluidDataCell(
                        child: Text("cell8"),
                        decoration: BoxDecoration(color: Colors.red),
                      ),
                      FluidDataCell(
                        child: Text("cell9"),
                        decoration: BoxDecoration(color: Colors.redAccent),
                      ),
                      FluidDataCell(
                        child: Text("cell10"),
                        decoration: BoxDecoration(color: Colors.redAccent),
                      ),
                    ],
                  ),
                  FluidRow(
                    height: 60,
                    cells: [
                      FluidDataCell(child: Text("cell11")),
                      FluidDataCell(child: Text("cell12")),
                      FluidDataCell(child: Text("cell13")),
                      FluidDataCell(child: Text("cell14")),
                      FluidDataCell(child: Text("cell15")),
                    ],
                  ),
                  FluidRow(
                    height: 70,
                    cells: [
                      FluidDataCell(child: Text("cell16")),
                      FluidDataCell(child: Text("cell17")),
                      FluidDataCell(child: Text("cell18")),
                      FluidDataCell(child: Text("cell19")),
                      FluidDataCell(child: Text("cell20")),
                    ],
                  ),
                  FluidRow(
                    color: Colors.blueAccent,
                    cells: [
                      FluidDataCell(
                        child: Text("cell21"),
                        decoration: BoxDecoration(
                          // color: Colors.purple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      FluidDataCell(
                        child: Text("cell22"),
                        // decoration: BoxDecoration(color: Colors.purple),
                      ),
                      FluidDataCell(
                        child: Text("cell23"),
                        // decoration: BoxDecoration(color: Colors.purple),
                      ),
                      FluidDataCell(
                        child: Text("cell24"),
                        // decoration: BoxDecoration(color: Colors.purple),
                      ),
                      FluidDataCell(
                        child: Text("cell25"),
                        decoration: BoxDecoration(
                          // color: Colors.purple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              Container(
                height: 1,
                width: 20,
                color: Colors.black,
                margin: EdgeInsets.all(20),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.orange,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.orange,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
