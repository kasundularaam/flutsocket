import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart" as latLng;

import '../../../logic/cubit/get_location_cubit/get_location_cubit.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetLocationCubit>(context).getLocation();
    return Scaffold(
      body: SafeArea(child: BlocBuilder<GetLocationCubit, GetLocationState>(
        builder: (context, state) {
          if (state is GetLocationGetting) {
            return FlutterMap(
              options: MapOptions(
                center: latLng.LatLng(state.latLong.lat, state.latLong.long),
                zoom: 13.0,
              ),
              children: [
                // BlocBuilder<GetLocationCubit, GetLocationState>(
                //   builder: (context, state) {
                //     if (state is GetLocationGetting) {
                //       print(state.latLong);
                //       return MarkerLayerWidget(
                //           options: MarkerLayerOptions(markers: [
                //         Marker(
                //           width: 80.0,
                //           height: 80.0,
                //           point: latLng.LatLng(51.5, -0.09),
                //           builder: (ctx) => Icon(Icons.location_on),
                //         )
                //       ]));
                //     } else {
                //       return const SizedBox();
                //     }
                //   },
                // )
              ],
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                  attributionBuilder: (_) {
                    return Text("© OpenStreetMap contributors");
                  },
                ),
                MarkerLayerOptions(markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: latLng.LatLng(state.latLong.lat, state.latLong.long),
                    builder: (ctx) => Icon(Icons.location_on),
                  )
                ])
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      )),
    );
  }
}
