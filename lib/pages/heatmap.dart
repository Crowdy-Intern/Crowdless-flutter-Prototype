import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../widgets/drawer.dart';

const crowd_blauton = const Color(0xFF3A4D5D);

class heatmapCell {
  final int load;
  final int hour;
  final int weekday;
  final num lat;
  final num lng;

  heatmapCell({this.load, this.hour, this.weekday, this.lat, this.lng});

  factory heatmapCell.fromJson(Map<String, dynamic> json) {
    return heatmapCell(
      load: json['load'] as int,
      hour: json['hour'] as int,
      weekday: json['weekday'] as int,
      lat: json['lat'] as num,
      lng: json['lng'] as num,
    );
  }
}

List<heatmapCell> parseHeatmapCells(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<heatmapCell>((json) => heatmapCell.fromJson(json)).toList();
}

Future<String> _loadHeatmapCellsAsset() async {
  return await rootBundle.loadString('assets/heatmaps_bern_swisscom_mod.json');
}

Future<List<heatmapCell>> _loadHeatmapCells() async {
  String jsonString = await _loadHeatmapCellsAsset();
  print('JSON Loaded');
  return compute(parseHeatmapCells, jsonString);
}

class MapPage extends StatefulWidget {
  static const String route = '/';

  String getRoute() {
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
  static LatLng bern = LatLng(46.936902035920376, 7.43279159346369);

  LatLng showLocation = zurich;
  String searchFor = '';
  static const String route = '/';

  MapController mapController;

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Row(children: [
        Image.asset(
          ('assets/icons/logo_color_small.png'),
//          fit: BoxFit.contain,
          height: 60,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: ' CROWDY',
                  style: TextStyle(
                      color: crowd_blauton,
                      fontSize: 31,
                      fontWeight: FontWeight.w900)),
            ])),
            RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: ' Sharing safety',
                  style: TextStyle(
                      fontFamily: "montserrat",
                      color: crowd_blauton,
                      fontSize: 30,
                      fontWeight: FontWeight.normal)),
            ])),
          ],
        ),
      ]),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30)),
      actions: [
        FlatButton(
          child: Text("Let's go!"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => showAlertDialog(context));
  }

  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  var markers = <Marker>[];
  var grid_size_hori = 11;
  var grid_size_vert = 8;

  void _addMarkerFromList(List<heatmapCell> heatmapCells) {
    while (markers.isNotEmpty) {
      markers.removeLast();
    }
    if (screenSize(context).aspectRatio > 1) {
      grid_size_hori = 6;
      grid_size_vert = 15;
    } else {
      grid_size_hori = 11;
      grid_size_vert = 8;
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
        var min_screen_side = screenSize(context).shortestSide;
        var minDistance = 1000.0;
        heatmapCell closesedCell;
        for (heatmapCell cell in heatmapCells) {
          if (cell.weekday == 0) {
            if (cell.hour == 15) {
              var x = latitude - cell.lat;
              var y = longitude - cell.lng;
              var distance = x * x + y * y;
              if (distance < minDistance) {
                minDistance = distance;
                closesedCell = cell;
              }
            }
          }
        }
        ;

        if (minDistance < 0.0001) {
          minDistance = minDistance * 1e5;
          markers.add(Marker(
            point: LatLng(latitude, longitude),
            builder: (ctx) => Container(
                child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.stop,
                size: min_screen_side * 0.2,
                color: getRandColor(
                    closesedCell.load), // Colors.green.withOpacity(0.5),
              ),
            )),
          ));
        }
      }
    }
  }

  Color getRandColor(int r) {
    if (r < 15) {
      return Colors.green.withOpacity(0.5);
    } else if (r < 35) {
      return Colors.orange.withOpacity(0.5);
    } else {
      return Colors.red.withOpacity(0.5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              ('assets/icons/logo_color_small.png'),
              fit: BoxFit.contain,
              height: 32,
            ),
            Text(' Crowdy - Your Level: '),
            Image.asset(
              ('assets/4Goldfaultier.png'),
              fit: BoxFit.contain,
              height: 32,
            ),
          ],
        ),
      ),
      drawer: buildDrawer(context, route),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _loadHeatmapCells().then((value) {
            _addMarkerFromList(value);

            setState(() {
              markers = List.from(markers);
            });
          });
          ;
        },
        icon: Icon(Icons.loop),
        label: Text("Show occupancy"),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: bern,
              zoom: 14.0,
            ),
            layers: [
              TileLayerOptions(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c']),
              MarkerLayerOptions(markers: markers)
            ],
          ),
/*          Positioned(
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
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          hintText: "Search..."),
                    ),
                  ),
                ],
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
