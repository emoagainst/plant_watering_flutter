import 'package:plant_watering/main.dart';
import 'package:plant_watering/src/actions/watering_actions.dart';
import 'package:plant_watering/src/data/states.dart';
import 'package:plant_watering/src/db/watering.dart';
import 'package:redux/redux.dart';


List<Middleware<AppState>> createWateringDbMiddleware(
  WateringDao wateringDao,
) {
  final saveWatering = _createSaveWatering(wateringDao);

  return [
    TypedMiddleware<AppState, AddWateringAction>(saveWatering),
  ];
}

Middleware<AppState> _createSaveWatering(WateringDao wateringDao) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is AddWateringAction){
      final wateringData = action.wateringData;
      final wateringId = await wateringDao.insert(wateringData.toEntity());
      wateringData.id = wateringId;
      next(AddWateringAction(wateringData));
      navigatorKey.currentState?.popUntil((route) => route.isFirst);
      return;
    }
    next(action);
  };
}
