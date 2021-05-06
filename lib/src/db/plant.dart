import 'package:plant_watering/src/db/room.dart';
import 'package:sqflite/sqflite.dart';

const String tablePlant = "plant";
const String _columnId = "_id";
const String _columnName = "name";
const String _columnRoomId = "room_id";
const String _columnDescription = "description";
const String _columnPhotoUrl = "photo_url";
const String tablePlantFk_id = _columnId;

class PlantEntity {
  final int? id;
  final String name;
  final int? roomId;
  final String? description;
  final String? photoUrl;

  PlantEntity({
    required this.id,
    required this.name,
    required this.roomId,
    required this.description,
    required this.photoUrl,
  });

  PlantEntity.fromMap(Map<String, dynamic> map):
    id = map[_columnId],
    name = map[_columnName],
    description = map[_columnDescription],
    photoUrl = map[_columnPhotoUrl],
    roomId = map[_columnRoomId];


  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      _columnName: name,
      _columnDescription: description,
      _columnPhotoUrl: photoUrl,
      _columnRoomId: roomId,
    };
    if (id != null) {
      map[_columnId] = id;
    }
    return map;
  }

  static const String CREATE_TABLE =
      'CREATE TABLE '
      '$tablePlant ('
      '$_columnId INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$_columnName TEXT, '
      '$_columnDescription TEXT, '
      '$_columnPhotoUrl TEXT, '
      '$_columnRoomId INTEGER,'
      'FOREIGN KEY($_columnRoomId) REFERENCES $tableRoom($tableRoomFk_id));';
}

class PlantDao {
  final Database database;

  PlantDao(this.database);

  Future<List<PlantEntity>> findAll() async {
    final maps = await database.query(tablePlant);
    return maps.map((e) => PlantEntity.fromMap(e)).toList();
  }

  void insertAll(List<PlantEntity> list) async {
    print("insert plants");
  }

  Future<int> insert(PlantEntity plant) async {
    return await database.insert(tablePlant, plant.toMap());
  }
}
