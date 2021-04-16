import 'package:plant_watering/src/data/room.dart';

import 'app_actions.dart';

abstract class RoomAction extends PlantWateringAppAction {

  @override
  String toString() {
    return '$runtimeType';
  }
}


class RoomsLoadingRequestedAction extends RoomAction{}

class RoomsLoadingSucceededAction extends RoomAction {
  final List<RoomData> rooms;

  RoomsLoadingSucceededAction(this.rooms);
}

class RoomsLoadingFailedAction extends RoomAction {}

class AddRoomAction extends RoomAction {
  static int _id = 0;
  final RoomData roomData;

  AddRoomAction(this.roomData){
    _id ++;
  }

  int get id => _id;
}

class RoomsLoadingChanged extends RoomAction {
  static int _id= 0;
  final bool isLoading;

  RoomsLoadingChanged(this.isLoading){
    _id++;
  }

  int get id => _id;
}

