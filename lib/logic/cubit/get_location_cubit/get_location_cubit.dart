import 'package:bloc/bloc.dart';
import 'package:flutsocket/data/http/http_client.dart';
import 'package:flutsocket/data/models/lat_long.dart';
import 'package:meta/meta.dart';

part 'get_location_state.dart';

class GetLocationCubit extends Cubit<GetLocationState> {
  GetLocationCubit() : super(GetLocationInitial());

  void getLocation() {
    try {
      SocketActivity.getLocation().listen((latLong) {
        emit(GetLocationGetting(latLong: latLong));
      });
    } catch (e) {
      emit(GetLocationFailed(errorMsg: e.toString()));
    }
  }
}
