import 'package:plant_watering/src/actions/app_actions.dart';
import 'package:plant_watering/src/data/watering.dart';

abstract class WateringAction extends PlantWateringAppAction {
  @override
  String toString() {
    return '$runtimeType';
  }
}

class AddWateringAction extends WateringAction {
  static int _id = 0;
  final WateringData wateringData;

  AddWateringAction(this.wateringData) {
    _id++;
  }

  int get id => _id;
}