import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHome();
}

class _MyHome extends State<MyHomePage> {
  int currPageIndex = 0;
  MapController mapController = MapController();

  void onCenter() {
    mapController.move(const LatLng(-6.1063392, 106.7824432), 15);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        FlutterMap(
          mapController: mapController,
          options: const MapOptions(
              initialCenter: LatLng(-6.1063392, 106.7824432), initialZoom: 15),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            ),
            const MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(-6.106689667319609, 106.77915210653327),
                  child: Icon(Icons.location_on),
                ),
                Marker(
                  point: LatLng(-6.116073137563247, 106.77919106292367),
                  child: Icon(Icons.location_on),
                ),
              ],
            ),
            PolylineLayer(polylines: [
              Polyline(points: const [
                LatLng(-6.106689667319609, 106.77915210653327),
                LatLng(-6.108944815388905, 106.77866390084417),
                LatLng(-6.109808982837228, 106.780112406572),
                LatLng(-6.110565128210051, 106.77989513071284),
                LatLng(-6.112293456478956, 106.78453034904196),
                LatLng(-6.117622433489337, 106.78366124560524),
                LatLng(-6.11655915246192, 106.77923492619186),
                LatLng(-6.116073137563247, 106.77919106292367)
              ], color: Colors.blue, strokeWidth: 6)
            ])
          ],
        ),
        Positioned(
          top: 10,
          left: 15,
          right: 15,
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: const Row(
              children: <Widget>[
                IconButton(
                    onPressed: null,
                    icon: Icon(Icons.menu),
                    splashColor: Colors.grey),
                Expanded(
                    child: TextField(
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.go,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: 'Insert route...'),
                )),
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('KH'),
                  ),
                )
              ],
            ),
          ),
        )
      ]),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currPageIndex = index;
          });
        },
        indicatorColor: Colors.blue[200],
        selectedIndex: currPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
              icon: Icon(Icons.route),
              selectedIcon: Icon(Icons.route_outlined),
              label: 'Local loop'),
          NavigationDestination(
              icon: Icon(Icons.map),
              selectedIcon: Icon(Icons.map_outlined),
              label: 'My map'),
          NavigationDestination(
              // icon: Icon(Icons.storage),
              icon: Badge(label: Text('5'), child: Icon(Icons.storage)),
              selectedIcon: Icon(Icons.storage_outlined),
              label: 'Rack')
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        onPressed: onCenter,
        child: const Icon(
          Icons.my_location,
        ),
      ),
    );
  }
}
