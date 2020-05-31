import 'dart:math';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';

import '../widgets/drawer.dart';

class StoreMap extends StatefulWidget {
  static const String route = 'storemap';

  String getRoute() {
    return route;
  }

  @override
  StoreMapState createState() {
    return StoreMapState();
  }
}

class StoreMapState extends State<StoreMap> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static LatLng zurich = LatLng(47.37174, 8.54226);
  static LatLng basel = LatLng(47.5596, 7.5886);
  LatLng showLocation = zurich;
  String searchFor = '';
  static const String route = 'storemap';

  MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  var markers = <Marker>[];
  var grid_size_hori = 11;
  var grid_size_vert = 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              ('assets/icons/logo_crowdy_small.png'),
              fit: BoxFit.contain,
              height: 32,
            ),
            Text(' Find store to use points: '),
          ],
        ),
      ),
      drawer: buildDrawer(context, route),
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
