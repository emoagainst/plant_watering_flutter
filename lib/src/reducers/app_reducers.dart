import 'package:plant_watering/src/data/plant_watering_app.dart';
import 'package:plant_watering/src/reducers/plant_reducers.dart';
import 'package:plant_watering/src/reducers/room_reducers.dart';

import 'navigation_reducers.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    plantsLoading: plantsLoadingReducer(state.plantsLoading, action),
    roomsLoading: roomsLoadingReducer(state.roomsLoading, action),
    plants: plantsReducer(state.plants, action),
    rooms: roomsReducer(state.rooms, action),
    selectedNavigationItem: navigationReducer(state.selectedNavigationItem, action),
  );
}