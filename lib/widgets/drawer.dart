import 'package:flutter/material.dart';

import '../pages/ranking.dart';
import '../pages/heatmap.dart';
import '../pages/storeMap.dart';
import '../pages/about.dart';

Drawer buildDrawer(BuildContext context, String currentRoute) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        DrawerHeader(
          child: Image(
            image: AssetImage('assets/icons/logo_medium.png'),
          ),
          decoration: BoxDecoration(
            color: Color(0xffF8E2B0),
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
        ListTile(
          title: const Text('Local stores'),
          selected: currentRoute == StoreMap.route,
          onTap: () {
            Navigator.pushReplacementNamed(context, StoreMap.route);
          },
        ),
        ListTile(
          title: const Text('About'),
          selected: currentRoute == About.route,
          onTap: () {
            Navigator.pushReplacementNamed(context, About.route);
          },
        ),
      ],
    ),
  );
}
