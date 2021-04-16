import 'package:plant_watering/src/actions/plant_actions.dart';
import 'package:plant_watering/src/data/plant.dart';
import 'package:plant_watering/src/data/plant_watering_app.dart';
import 'package:plant_watering/src/db/plant.dart';
import 'package:redux/redux.dart';

import '../logger.dart';

List<Middleware<AppState>> createPlantsDbMiddleware(
  PlantDao plantDao,
) {
  final savePlant = _createSavePlant(plantDao);
  final loadPlants = _createLoadPlants(plantDao);

  return [
    TypedMiddleware<AppState, PlantsLoadingRequestedAction>(loadPlants),
    TypedMiddleware<AppState, AddPlantAction>(savePlant),
  ];
}

Middleware<AppState> _createLoadPlants(PlantDao plantDao) {
  return (Store<AppState> store, action, NextDispatcher next) {
    plantDao.findAll().then(
      (plantEntities) {
        final plantDatas = plantEntities.map((plantEntity) => PlantData.fromEntity(plantEntity)).toList();
        store.dispatch(PlantsLoadingSucceededAction(plantDatas));
      },
    ).catchError((e) {
      logger.e("Error plantDao.findAll", e);
      store.dispatch(PlantsLoadingFailedAction());
    });

    next(action);
  };
}

Middleware<AppState> _createSavePlant(PlantDao plantDao) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is AddPlantAction) {
      final plantData = action.plantData;
      final plantId = await plantDao.insert(plantData.toEntity());
      plantData.id = plantId;
      next(AddPlantAction(plantData));
      return;
    }
    next(action);
  };
}
