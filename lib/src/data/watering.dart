import 'package:plant_watering/src/data/plant.dart';
import 'package:plant_watering/src/db/watering.dart';

class WateringData {
  int? id;
  int periodInDays;
  DateTime lastWateringDate;
  PlantData? plant;

  WateringData({
    required this.id,
    required this.periodInDays,
    required this.lastWateringDate,
    required this.plant,
  });

  WateringData.initial()
      : periodInDays = -1,
        lastWateringDate = DateTime.now();

  WateringData.fromEntity(WateringEntity entity)
      : id = entity.id,
        periodInDays = entity.periodInDays,
        lastWateringDate = DateTime.parse(entity.lastWateringDate),
        plant = PlantData(id: entity.plantId, name: "", room: null);

  @override
  String toString() {
    return 'WateringData{id: $id, periodInDays: $periodInDays, lastWateringDate: $lastWateringDate, plant: $plant}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WateringData && runtimeType == other.runtimeType && id == other.id && periodInDays == other.periodInDays && lastWateringDate == other.lastWateringDate && plant == other.plant;

  @override
  int get hashCode => id.hashCode ^ periodInDays.hashCode ^ lastWateringDate.hashCode ^ plant.hashCode;

  WateringEntity toEntity() => WateringEntity(id: id, lastWateringDate: lastWateringDate.toIso8601String(), periodInDays: periodInDays, plantId: plant?.id);
}
