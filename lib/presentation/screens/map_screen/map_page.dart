import 'package:flutsocket/logic/cubit/get_location_cubit/get_location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart" as latLng;

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FlutterMap(
        options: MapOptions(
          center: latLng.LatLng(51.5, -0.09),
          zoom: 13.0,
        ),
        children: [
          BlocBuilder<GetLocationCubit, GetLocationState>(
            builder: (context, state) {
              return MarkerLayerWidget(
                  options: MarkerLayerOptions(markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: latLng.LatLng(51.5, -0.09),
                  builder: (ctx) => Container(
                    child: FlutterLogo(),
                  ),
                )
              ]));
            },
          )
        ],
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            attributionBuilder: (_) {
              return Text("© OpenStreetMap contributors");
            },
          ),
        ],
      )),
    );
  }
}
