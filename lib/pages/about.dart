import 'package:flutter/material.dart';
import '../widgets/drawer.dart';

/// This is the stateless widget that the main application instantiates.
class About extends StatelessWidget {
  static const String route = 'about';
  About({Key key}) : super(key: key);

  Image getLevelIcon(int points){

  }

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
              child: Text("Developed by Crowdy. www.crowdy.ch")
            ),
          ],
        ),
      ),
    );
  }
}