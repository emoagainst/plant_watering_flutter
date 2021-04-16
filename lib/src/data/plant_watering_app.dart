import 'package:plant_watering/src/core/navigation.dart';
import 'package:plant_watering/src/data/plant.dart';
import 'package:plant_watering/src/data/room.dart';

class AppState {
  final bool plantsLoading;
  final bool roomsLoading;
  final List<PlantData> plants;
  final List<RoomData> rooms;
  final PlantWateringNavigationItem selectedNavigationItem;

  AppState({
    this.plantsLoading = true,
    this.roomsLoading = true,
    this.plants = const <PlantData>[],
    this.rooms = const <RoomData>[],
    this.selectedNavigationItem = PlantWateringNavigationItem.plants,
  });
}
