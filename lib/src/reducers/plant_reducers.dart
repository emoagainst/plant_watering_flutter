import 'package:plant_watering/src/actions/plant_actions.dart';
import 'package:plant_watering/src/core/routes.dart';
import 'package:plant_watering/src/data/plant.dart';
import 'package:plant_watering/src/data/states.dart';
import 'package:redux/redux.dart';

import '../../main.dart';

final plantsStateReducer = combineReducers<PlantsState>([
  TypedReducer<PlantsState, PlantsLoadingSucceededAction>(plantsLoadingReducer),
  TypedReducer<PlantsState, PlantsLoadingFailedAction>(plantsLoadingReducer),
  TypedReducer<PlantsState, AddPlantAction>(_addPlantReducer),
  TypedReducer<PlantsState, PlantsLoadingSucceededAction>(_plantsLoadedReducer),
]);

PlantsState _plantsLoadedReducer(PlantsState state, PlantsLoadingSucceededAction action) {
  return state.copyWith(plants: action.plants);
}

PlantsState _addPlantReducer(PlantsState state, AddPlantAction action) {
  navigatorKey.currentState?.pushNamed(PlantWateringRoutes.addPlantWatering, arguments: action.plantData.id);
  return state.copyWith(
      plants: <PlantData>[]
        ..addAll(state.plants)
        ..add(action.plantData),
      createdPlantId: action.plantData.id);
}

final plantsLoadingReducer = combineReducers<PlantsState>([
  TypedReducer<PlantsState, PlantsLoadingSucceededAction>(_setLoading),
  TypedReducer<PlantsState, PlantsLoadingFailedAction>(_setLoading),
]);

PlantsState _setLoading(PlantsState state, action) {
  return state.copyWith(plantsLoading: false);
}
