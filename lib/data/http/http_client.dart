import 'dart:async';

import 'package:flutsocket/data/models/lat_long.dart';
import 'package:geolocator/geolocator.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class StreamSocket {
  final _socketResponse = StreamController<LatLong>();

  void Function(LatLong) get addResponse => _socketResponse.sink.add;

  Stream<LatLong> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

class SocketActivity {
  static IO.Socket socket =
      IO.io('http://192.168.8.101:3000', <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false
  });

  static Stream<LatLong> getLocation() async* {
    StreamSocket streamSocket = StreamSocket();
    socket.connect();
    socket.on('user', (data) {
      LatLong latLong = LatLong(lat: data["lat"], long: data["long"]);
      streamSocket.addResponse(latLong);
    });

    yield* streamSocket.getResponse;
  }

  static Future<bool> isPermissionAllowed() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return true;
  }

  static Stream<LatLong> sendLocation() async* {
    StreamSocket streamSocket = StreamSocket();
    socket.connect();
    Geolocator.getPositionStream().listen(
      (Position? position) {
        streamSocket.addResponse(
            LatLong(lat: position!.latitude, long: position.longitude));
        socket.emit(
          "driver",
          {"lat": position.latitude, "long": position.longitude},
        );
      },
    );
    yield* streamSocket.getResponse;
  }
}
