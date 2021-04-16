import 'package:plant_watering/src/actions/room_actions.dart';
import 'package:plant_watering/src/data/room.dart';
import 'package:redux/redux.dart';

final roomsReducer = combineReducers<List<RoomData>>([
  TypedReducer<List<RoomData>, AddRoomAction>(_addRoomReducer),
  TypedReducer<List<RoomData>, RoomsLoadingSucceededAction>(_roomsLoadedReducer),
]);

List<RoomData> _roomsLoadedReducer (List<RoomData> state, RoomsLoadingSucceededAction action) {
  return action.rooms;
}

List<RoomData> _addRoomReducer(List<RoomData> state, AddRoomAction action) {
  return <RoomData>[]
      ..addAll(state)
      ..add(action.roomData);
}

final roomsLoadingReducer = combineReducers<bool>([
  TypedReducer<bool, RoomsLoadingSucceededAction>(_setLoading),
  TypedReducer<bool, RoomsLoadingFailedAction>(_setLoading),
]);

bool _setLoading(bool state, action){
  return false;
}

