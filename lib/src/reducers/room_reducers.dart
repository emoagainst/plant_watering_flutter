import 'package:plant_watering/src/actions/room_actions.dart';
import 'package:plant_watering/src/data/room.dart';
import 'package:plant_watering/src/data/states.dart';
import 'package:redux/redux.dart';

final roomsStateReducer = combineReducers<RoomsState>([
  TypedReducer<RoomsState, RoomsLoadingSucceededAction>(roomsLoadingReducer),
  TypedReducer<RoomsState, RoomsLoadingFailedAction>(roomsLoadingReducer),
  TypedReducer<RoomsState, AddRoomAction>(_addRoomReducer),
  TypedReducer<RoomsState, RoomsLoadingSucceededAction>(_roomsLoadedReducer),
]);

RoomsState _roomsLoadedReducer (RoomsState state, RoomsLoadingSucceededAction action) {
  return state.copyWith(rooms: action.rooms);
}

RoomsState _addRoomReducer(RoomsState state, AddRoomAction action) {
  return state.copyWith(rooms: <RoomData>[]
    ..addAll(state.rooms)
    ..add(action.roomData));
}

final roomsLoadingReducer = combineReducers<RoomsState>([
  TypedReducer<RoomsState, RoomsLoadingSucceededAction>(_setLoading),
  TypedReducer<RoomsState, RoomsLoadingFailedAction>(_setLoading),
]);

RoomsState _setLoading(RoomsState state, action){
  return state.copyWith(roomsLoading: false);
}

