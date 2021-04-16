import 'package:plant_watering/src/actions/room_actions.dart';
import 'package:plant_watering/src/data/plant_watering_app.dart';
import 'package:plant_watering/src/data/room.dart';
import 'package:plant_watering/src/db/room.dart';
import 'package:redux/redux.dart';

import '../logger.dart';

List<Middleware<AppState>> createRoomsDbMiddleware(
  RoomDao roomDao,
) {
  final saveRoom = _createSaveRoom(roomDao);
  final loadRooms = _createLoadRooms(roomDao);

  return [
    TypedMiddleware<AppState, RoomsLoadingRequestedAction>(loadRooms),
    TypedMiddleware<AppState, AddRoomAction>(saveRoom),
  ];
}

Middleware<AppState> _createLoadRooms(RoomDao roomDao) {
  return (Store<AppState> store, action, NextDispatcher next) {
    roomDao.findAll().then(
      (roomEntities) {
        final roomDatas = roomEntities.map((roomEntity) => RoomData.fromEntity(roomEntity)).toList();
        store.dispatch(RoomsLoadingSucceededAction(roomDatas));
      },
    ).catchError((e) {
      logger.e("Error roomDao.findAll", e);
      store.dispatch(RoomsLoadingFailedAction());
    });

    next(action);
  };
}

Middleware<AppState> _createSaveRoom(RoomDao roomDao) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is AddRoomAction) {
      final roomData = action.roomData;
      int roomId = await roomDao.insert(roomData.toEntity());
      roomData.id = roomId;
      next(AddRoomAction(roomData));
      return;
    }
    next(action);
  };
}
