import 'package:flutsocket/logic/cubit/send_location_cubit/send_location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart" as latLng;

class DriverPage extends StatefulWidget {
  const DriverPage({Key? key}) : super(key: key);

  @override
  _DriverPageState createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SendLocationCubit>(context).sendLocation();
    return Scaffold(
      body: SafeArea(child: BlocBuilder<SendLocationCubit, SendLocationState>(
        builder: (context, state) {
          if (state is SendLocationSending) {
            return FlutterMap(
              options: MapOptions(
                center: latLng.LatLng(state.latLong.lat, state.latLong.long),
                zoom: 13.0,
              ),
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
              // children: [
              //   BlocBuilder<SendLocationCubit, SendLocationState>(
              //     builder: (context, state) {
              //       if (state is SendLocationSending) {
              //         return MarkerLayerWidget(
              //             options: MarkerLayerOptions(markers: [
              //           Marker(
              //             width: 80.0,
              //             height: 80.0,
              //             point: latLng.LatLng(
              //                 state.latLong.lat, state.latLong.long),
              //             builder: (ctx) => Container(
              //               child: FlutterLogo(),
              //             ),
              //           )
              //         ]));
              //       } else {
              //         return const SizedBox();
              //       }
              //     },
              //   )
              // ],
            );
          } else {
            return SizedBox();
          }
        },
      )),
    );
  }
}
