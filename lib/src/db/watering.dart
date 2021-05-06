import 'package:plant_watering/src/db/plant.dart';
import 'package:sqflite/sqflite.dart';

const String tableWatering = "watering";
const String _columnId = "_id";
const String _columnPeriodInDays = "period";
const String _columnLastWateringDate = "last_date";
const String _columnPlantId = "plant_id";

class WateringEntity {
  final int? id;
  final int periodInDays;
  final String lastWateringDate;
  final int? plantId;

  WateringEntity({
    required this.id,
    required this.periodInDays,
    required this.lastWateringDate,
    required this.plantId,
  });

  WateringEntity.fromMap(Map<String, dynamic> map)
      : id = map[_columnId],
        periodInDays = map[_columnPeriodInDays],
        lastWateringDate = map[_columnLastWateringDate],
        plantId = map[_columnPlantId];

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      _columnPeriodInDays: periodInDays,
      _columnLastWateringDate: lastWateringDate,
      _columnPlantId: plantId,
    };
    if (id != null) {
      map[_columnId] = id;
    }
    return map;
  }

  static const String CREATE_TABLE = 'CREATE TABLE '
      '$tableWatering ('
      '$_columnId INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$_columnPeriodInDays INTEGER, '
      '$_columnLastWateringDate TEXT, '
      '$_columnPlantId INTEGER, '
      'FOREIGN KEY($_columnPlantId) REFERENCES $tablePlant($tablePlantFk_id));';
}

class WateringDao {
  final Database database;

  WateringDao(this.database);

  Future<int> insert(WateringEntity watering) async {
    return await database.insert(tableWatering, watering.toMap());
  }
}
