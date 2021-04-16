import 'package:plant_watering/src/data/plant.dart';
import 'package:plant_watering/src/db/room.dart';

class RoomData {
  int? id;
  String? name;

  RoomData({required this.id, required this.name});

  RoomData.initial() : name = "";

  RoomData.fromEntity(RoomEntity entity)
      : id = entity.id,
        name = entity.name;

  @override
  String toString() {
    return 'RoomData{id: $id, name: $name}';
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is RoomData && runtimeType == other.runtimeType && id == other.id && name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  RoomEntity toEntity() => RoomEntity(id: id, name: name ?? "");
}

class RoomWithPlantsData {
  RoomData room;
  List<PlantData> plants;

  RoomWithPlantsData({required this.room, this.plants = const []});

  @override
  String toString() {
    return 'RoomWithPlantsData{room: $room, plants: $plants}';
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is RoomWithPlantsData && runtimeType == other.runtimeType && room == other.room && plants == other.plants;

  @override
  int get hashCode => room.hashCode ^ plants.hashCode;
}
