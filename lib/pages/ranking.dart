import 'package:flutter/material.dart';
import '../widgets/drawer.dart';

/// This is the stateless widget that the main application instantiates.
class Ranking extends StatelessWidget {
  static const String route = 'ranking';
  Ranking({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ranking')),
      drawer: buildDrawer(context, Ranking.route),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
            children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text('Global Ranking'),
            ),
            Flexible(
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Nickname',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Points',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Rank',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Up/Down',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
                rows: const <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Sarah')),
                      DataCell(Text('200000')),
                      DataCell(Text('1')),
                      DataCell(Text('up')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Janine')),
                      DataCell(Text('33587')),
                      DataCell(Text('2')),
                      DataCell(Text('up')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('William')),
                      DataCell(Text('27')),
                      DataCell(Text('3')),
                      DataCell(Text('down')),
                ],
              ),
            ],
          ),
        ),
            ],
        ),
      ),
    );
  }
}