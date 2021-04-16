import 'package:plant_watering/src/data/plant.dart';

import 'app_actions.dart';

abstract class PlantAction extends PlantWateringAppAction {
  @override
  String toString() {
    return '$runtimeType';
  }
}

class PlantsLoadingRequestedAction extends PlantAction {}

class PlantsLoadingSucceededAction extends PlantAction {
  final List<PlantData> plants;

  PlantsLoadingSucceededAction(this.plants);
}

class PlantsLoadingFailedAction extends PlantAction {
  PlantsLoadingFailedAction();
}

class AddPlantAction extends PlantAction {
  static int _id = 0;
  final PlantData plantData;

  AddPlantAction(this.plantData) {
    _id++;
  }

  int get id => _id;
}

class PlantsLoadingChanged extends PlantAction {
  final bool isLoading;

  PlantsLoadingChanged(this.isLoading);
}
