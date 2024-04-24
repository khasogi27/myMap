import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const MyHomePage(),
      title: 'Flutter with map',
    );
  }
}

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
      appBar: AppBar(
        title: const Text('Map'),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.search),
            tooltip: 'Search',
          ),
          IconButton(onPressed: null, icon: Icon(Icons.account_circle_rounded))
        ],
      ),
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
      body: FlutterMap(
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
