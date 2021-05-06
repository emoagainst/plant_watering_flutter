import 'package:plant_watering/src/data/states.dart';
import 'package:plant_watering/src/reducers/plant_reducers.dart';
import 'package:plant_watering/src/reducers/room_reducers.dart';

import 'navigation_reducers.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    plantsState: plantsStateReducer(state.plantsState, action),
    roomsState: roomsStateReducer(state.roomsState, action),
    selectedNavigationItem: navigationReducer(state.selectedNavigationItem, action),
  );
}