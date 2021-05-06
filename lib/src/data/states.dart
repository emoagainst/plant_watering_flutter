import 'package:plant_watering/src/core/navigation.dart';
import 'package:plant_watering/src/data/plant.dart';
import 'package:plant_watering/src/data/room.dart';

class AppState {
  final PlantsState plantsState;
  final RoomsState roomsState;
  final PlantWateringNavigationItem selectedNavigationItem;

  const AppState({
    this.plantsState = const PlantsState(),
    this.roomsState = const RoomsState(),
    this.selectedNavigationItem = PlantWateringNavigationItem.plants,
  });
}

class PlantsState {
  final bool plantsLoading;
  final int createdPlantId;
  final List<PlantData> plants;

  const PlantsState({
    this.plantsLoading = true,
    this.createdPlantId = -1,
    this.plants = const <PlantData>[],
  });

  PlantsState copyWith({bool? plantsLoading, int? createdPlantId, List<PlantData>? plants}) {
    return PlantsState(
      plantsLoading : plantsLoading ?? this.plantsLoading,
      plants: plants ?? this.plants,
      createdPlantId: createdPlantId ?? this.createdPlantId
    );
  }
}

class RoomsState {
  final bool roomsLoading;
  final List<RoomData> rooms;

  const RoomsState({
    this.roomsLoading = true,
    this.rooms = const <RoomData>[],
  });

  RoomsState copyWith({bool? roomsLoading, List<RoomData>? rooms}) {
    return RoomsState(
        roomsLoading : roomsLoading ?? this.roomsLoading,
        rooms: rooms ?? this.rooms
    );
  }
}
