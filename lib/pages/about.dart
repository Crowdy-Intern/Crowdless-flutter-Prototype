import 'package:flutter/material.dart';
import '../widgets/drawer.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'dart:async';

import 'package:url_launcher/url_launcher.dart';

/// This is the stateless widget that the main application instantiates.
class About extends StatelessWidget {
  static const String route = 'about';
  About({Key key}) : super(key: key);

  Image getLevelIcon(int points) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About Crowdy')),
      drawer: buildDrawer(context, About.route),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(''),
            ),
            Flexible(
              child: Linkify(
                onOpen: _onOpen,
                text: "Developed by Crowdy. https://www.crowdy.ch",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }
}
//Text("")
