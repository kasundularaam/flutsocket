part of 'get_location_cubit.dart';

@immutable
abstract class GetLocationState {}

class GetLocationInitial extends GetLocationState {}

class GetLocationGetting extends GetLocationState {
  final LatLong latLong;
  GetLocationGetting({
    required this.latLong,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetLocationGetting && other.latLong == latLong;
  }

  @override
  int get hashCode => latLong.hashCode;

  @override
  String toString() => 'GetLocationGetting(latLong: $latLong)';
}

class GetLocationFailed extends GetLocationState {
  final String errorMsg;
  GetLocationFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetLocationFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'GetLocationFailed(errorMsg: $errorMsg)';
}
