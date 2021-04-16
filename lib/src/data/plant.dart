import 'package:plant_watering/src/data/room.dart';
import 'package:plant_watering/src/db/plant.dart';

class PlantData {
  int? id;
  String name;
  RoomData? room;
  String? description;
  String? photoUrl;

  PlantData({required this.id, required this.name, required this.room, this.description, this.photoUrl});

  PlantData.initial() : name = "";

  PlantData.fromEntity(PlantEntity entity)
      : id = entity.id,
        name = entity.name,
        room = RoomData(id: entity.roomId, name: null),
        description = entity.description,
        photoUrl = entity.photoUrl;

  @override
  String toString() {
    return 'PlantData{id: $id, name: $name, room: $room, description: $description, photoUrl: $photoUrl}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlantData && runtimeType == other.runtimeType && id == other.id && name == other.name && room == other.room && description == other.description && photoUrl == other.photoUrl;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ room.hashCode ^ description.hashCode ^ photoUrl.hashCode;

  PlantEntity toEntity() => PlantEntity(id: id, name: name, roomId: room?.id, description: description, photoUrl: photoUrl);
}
