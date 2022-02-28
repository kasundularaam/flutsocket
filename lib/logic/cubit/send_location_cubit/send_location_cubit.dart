import 'package:bloc/bloc.dart';
import 'package:flutsocket/data/http/http_client.dart';
import 'package:flutsocket/data/models/lat_long.dart';
import 'package:meta/meta.dart';

part 'send_location_state.dart';

class SendLocationCubit extends Cubit<SendLocationState> {
  SendLocationCubit() : super(SendLocationInitial());

  Future<void> sendLocation() async {
    try {
      bool isPermissionAllowed = await SocketActivity.isPermissionAllowed();
      if (isPermissionAllowed) {
        SocketActivity.sendLocation().listen((latLong) {
          emit(SendLocationSending(latLong: latLong));
        });
      } else {
        emit(SendLocationFailed(errorMsg: "Location Permission denied"));
      }
    } catch (e) {
      emit(
        SendLocationFailed(
          errorMsg: e.toString(),
        ),
      );
    }
  }
}
