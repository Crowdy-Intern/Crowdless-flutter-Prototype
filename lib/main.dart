import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import './pages/ranking.dart';
import './pages/heatmap.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crowdy',
      home: MapPage(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        Ranking.route: (context) => Ranking(),
      }
    );
  }
}
