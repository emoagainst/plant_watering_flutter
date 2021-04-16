import 'package:collection/collection.dart';
import 'package:plant_watering/src/core/navigation.dart';
import 'package:plant_watering/src/data/plant.dart';
import 'package:plant_watering/src/data/plant_watering_app.dart';
import 'package:plant_watering/src/data/room.dart';

List<PlantData> plantsSelector(AppState state) => state.plants;

bool plantsLoadingSelector(AppState state) => state.plantsLoading;

List<RoomData> roomsSelector(AppState state) => state.rooms;

bool roomsLoadingSelector(AppState state) => state.roomsLoading;

PlantWateringNavigationItem navigationSelector(AppState state) => state.selectedNavigationItem;

List<PlantData> plantsWithRoomSelector(List<PlantData> plants, List<RoomData> rooms) {
  return plants.map((plant) {
    final roomId = plant.room?.id;
    final room = rooms.firstWhereOrNull((room) => room.id == roomId);
    if (room != null) {
      plant.room = room;
    }
    return plant;
  }).toList();
}

List<RoomWithPlantsData> roomWithPlantsSelector(List<RoomData> rooms, List<PlantData> plants) {
  final roomsWithPlants = <RoomWithPlantsData>[];
  final groupedPlants = groupBy<PlantData, String>(plants, (plant) => plant.room?.name ?? "");
  // Create rooms with non empty plants
  groupedPlants.forEach((roomName, plants) {
    final room = rooms.firstWhere((element) => element.name == roomName, orElse: () => RoomData.initial());
    if (room != RoomData.initial()) {
      roomsWithPlants.add(RoomWithPlantsData(room: room, plants: plants));
    }
  });
  //Create rooms without plants
  rooms.forEach((room) {
    final foundRoom = roomsWithPlants.firstWhereOrNull((roomWithPlants) => roomWithPlants.room.name == room.name);
    if (foundRoom == null) {
      roomsWithPlants.add(RoomWithPlantsData(room: room, plants: []));
    }
  });

  return roomsWithPlants;
}
