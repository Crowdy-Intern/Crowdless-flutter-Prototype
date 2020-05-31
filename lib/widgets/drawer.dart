import 'package:flutter/material.dart';

import '../pages/ranking.dart';
import '../pages/heatmap.dart';


Drawer buildDrawer(BuildContext context, String currentRoute) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        const DrawerHeader(
          child: Center(
            child: Text('Crowdless menu'),
          ),
        ),

        ListTile(
          title: const Text('Heatmap'),
          selected: currentRoute == MapPage.route,
          onTap: () {
            Navigator.pushReplacementNamed(context, MapPage.route);
          },
        ),
        ListTile(
          title: const Text('Ranking'),
          selected: currentRoute == Ranking.route,
          onTap: () {
            Navigator.pushReplacementNamed(context, Ranking.route);
          },
        ),
      ],
    ),
  );
}
