import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../screens/homepage.dart';
import '../widgets/menuscreen.dart';

class DrawerZoom extends StatefulWidget {
  const DrawerZoom({Key? key}) : super(key: key);

  @override
  _DrawerZoomState createState() => _DrawerZoomState();

  static const routeName = '/drawer';
}

class _DrawerZoomState extends State<DrawerZoom> {
  final _zoomDrawer = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomDrawer(
        menuScreen: MenuScreen(),
        mainScreen: HomePage(_zoomDrawer),
        controller: _zoomDrawer,
        style: DrawerStyle.style1,
        menuBackgroundColor: Theme.of(context).shadowColor,
        showShadow: true,
        borderRadius: 20.0,
        angle: 0.0,
        slideWidth: MediaQuery.of(context).size.width * 0.63,
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.easeInCubic,
      ),
    );
  }
}
