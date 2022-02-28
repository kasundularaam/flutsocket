part of 'send_location_cubit.dart';

@immutable
abstract class SendLocationState {}

class SendLocationInitial extends SendLocationState {}

class SendLocationSending extends SendLocationState {
  final LatLong latLong;
  SendLocationSending({
    required this.latLong,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SendLocationSending && other.latLong == latLong;
  }

  @override
  int get hashCode => latLong.hashCode;

  @override
  String toString() => 'SendLocationSending(latLong: $latLong)';
}

class SendLocationFailed extends SendLocationState {
  final String errorMsg;
  SendLocationFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SendLocationFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'SendLocationFailed(errorMsg: $errorMsg)';
}
