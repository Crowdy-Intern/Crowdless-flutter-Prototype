import 'package:flutter/material.dart';
import '../widgets/drawer.dart';

/// This is the stateless widget that the main application instantiates.
class Ranking extends StatelessWidget {
  static const String route = 'ranking';
  Ranking({Key key}) : super(key: key);

  Image getLevelIcon(int points){

  }

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
                columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Level',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'User',
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
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                        DataCell(
                          Image.asset(('assets/4Goldfaultier.png'),
                          fit: BoxFit.contain,
                          height: 32,
                        ),
                      ),
                      DataCell(Text('Sarahhh')),
                      DataCell(Text('200000')),
                      DataCell(Text('1')),
                      DataCell(Text('up')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Image.asset(('assets/3Schildkroete.png'),
                          fit: BoxFit.contain,
                          height: 32,
                        ),
                      ),
                      DataCell(Text('Jannn33')),
                      DataCell(Text('33587')),
                      DataCell(Text('2')),
                      DataCell(Text('up')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Image.asset(('assets/1Affe.png'),
                          fit: BoxFit.contain,
                          height: 32,
                        ),
                      ),
                      DataCell(Text('Will')),
                      DataCell(Text('225')),
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