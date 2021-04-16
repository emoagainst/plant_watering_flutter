import 'package:plant_watering/src/actions/plant_actions.dart';
import 'package:plant_watering/src/data/plant.dart';
import 'package:redux/redux.dart';

final plantsReducer = combineReducers<List<PlantData>>([
  TypedReducer<List<PlantData>, AddPlantAction>(_addPlantReducer),
  TypedReducer<List<PlantData>, PlantsLoadingSucceededAction>(_plantsLoadedReducer),
]);

List<PlantData> _plantsLoadedReducer(List<PlantData> state, PlantsLoadingSucceededAction action) {
  return action.plants;
}

List<PlantData> _addPlantReducer(List<PlantData> state, AddPlantAction action) {
  return <PlantData>[]
    ..addAll(state)
    ..add(action.plantData);
}

final plantsLoadingReducer = combineReducers<bool>([
  TypedReducer<bool, PlantsLoadingSucceededAction>(_setLoading),
  TypedReducer<bool, PlantsLoadingFailedAction>(_setLoading),
]);

bool _setLoading(bool state, action) {
  return false;
}
