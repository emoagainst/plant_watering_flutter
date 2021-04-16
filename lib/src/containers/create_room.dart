import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:plant_watering/src/actions/room_actions.dart';
import 'package:plant_watering/src/data/plant_watering_app.dart';
import 'package:plant_watering/src/data/room.dart';
import 'package:plant_watering/src/presentation/create_room_widget.dart';
import 'package:redux/redux.dart';

class CreateRoom extends StatelessWidget {

  CreateRoom();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return CreateRoomField(onSaveRoom: vm.onSaveRoom);
      },
    );
  }
}

class _ViewModel {
  final Function(RoomData) onSaveRoom;

  _ViewModel({required this.onSaveRoom});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      onSaveRoom: (room) {
        store.dispatch(AddRoomAction(room));
      },
    );
  }
}
