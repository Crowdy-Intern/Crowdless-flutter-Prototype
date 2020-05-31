import 'dart:math';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';


import '../widgets/drawer.dart';

class MapPage extends StatefulWidget {
  static const String route = '/';

  String getRoute(){
    return route;
  }

  @override
  MapPageState createState() {
    return MapPageState();
  }
}

class MapPageState extends State<MapPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static LatLng zurich = LatLng(47.37174, 8.54226);
  static LatLng basel = LatLng(47.5596, 7.5886);
  LatLng showLocation = zurich;
  String searchFor = '';
  static const String route = '/';

  MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  var grid_size_hori = 11;
  var grid_size_vert = 8;
  var distance_bt_grid = 1;

  var markers = <Marker>[];
  void _addMarkerFromList() {
    while (markers.isNotEmpty) {
      markers.removeLast();
    }
    var map_corner_right_up = mapController.bounds.northEast;
    var map_corner_left_down = mapController.bounds.southWest;
    for (int grid_count_hori in [
      for (var i = -2; i < grid_size_hori + 2; i += 1) i
    ]) {
      var latitude = map_corner_right_up.latitude +
          (map_corner_left_down.latitude - map_corner_right_up.latitude) /
              grid_size_hori *
              grid_count_hori;
      for (int grid_count_verti in [
        for (var i = -2; i < grid_size_vert + 2; i += 1) i
      ]) {
        var longitude = map_corner_right_up.longitude +
            (map_corner_left_down.longitude - map_corner_right_up.longitude) /
                grid_size_vert *
                grid_count_verti;
        var rng = new Random();
        markers.add(Marker(
          point: LatLng(latitude, longitude),
          builder: (ctx) => Container(
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.stop,
                  size: 90.0,
                  color: getRandColor(rng.nextInt(100)),// Colors.green.withOpacity(0.5),
                ),
              )),
        ));
      }
    }
  }

  Color getRandColor(int r){
    if (r < 20){
      return Colors.red.withOpacity(0.5);
    } else if (r < 70) {
      return Colors.green.withOpacity(0.5);
    } else if (r < 100) {
      return Colors.orange.withOpacity(0.5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Row(
          children: [
            Image.asset(('assets/logo_round.png'),
            fit: BoxFit.contain,
            height: 32,
            ),
            Text('Crowdy - Your Level: '),
            Image.asset(('assets/4Goldfaultier.png'),
              fit: BoxFit.contain,
              height: 32,
            ),
          ],
        ),
      ),
      drawer: buildDrawer(context, route),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _addMarkerFromList();
          setState(() {
            markers = List.from(markers);
          });
        },
        icon: Icon(Icons.loop),
        label: Text("Show occupancy"),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: zurich,
              zoom: 14.0,
            ),
            layers: [
              TileLayerOptions(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c']),
              MarkerLayerOptions(markers: markers)
            ],
          ),
          Positioned(
            top: 10,
            right: 15,
            left: 15,
            child: Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  IconButton(
                    splashColor: Colors.grey,
                    icon: Icon(Icons.search),
                    onPressed: () {
                      print("pressed");
                      setState(() {
                        if (searchFor != 'Zürich') {
                          showLocation = basel;
                        } else {
                          showLocation = zurich;
                        }
                      });
                      mapController.move(showLocation, 14.0);
                    },
                  ),
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      onChanged: (text) {
                        setState(() {
                          searchFor = text;
                        });
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 15),
                          hintText: "Search..."),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
