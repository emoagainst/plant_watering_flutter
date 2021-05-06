
import 'package:sqflite/sqflite.dart';

const String tableRoom = 'room';
const String _columnId = '_id';
const String _columnName = 'name';
const String tableRoomFk_id = _columnId;

class RoomEntity {
  final int? id;
  final String name;

  RoomEntity({
    required this.id,
    required this.name,
  });

  RoomEntity.fromMap(Map<String, dynamic> map):
  id = map[_columnId],
  name = map[_columnName];


  Map<String, dynamic> toMap() {
    final map = <String, dynamic> {
      _columnName : name
    };
    if (id != null){
      map[_columnId] = id;
    }
    return map;
  }

  static const String CREATE_TABLE = 'CREATE TABLE $tableRoom ($_columnId INTEGER PRIMARY KEY AUTOINCREMENT, $_columnName TEXT);';
  static const String INSERT_PREDEFINED = 'INSERT INTO $tableRoom ($_columnId, $_columnName) VALUES (null, "Main Room"), (null, "Kitchen"), (null, "Hall"), (null, "Bathroom");';
}

class RoomDao {
  final Database database;

  RoomDao(this.database);

  Future<List<RoomEntity>> findAll() async{
    final maps = await database.query(tableRoom);
    final rooms = maps.map((e) => RoomEntity.fromMap(e)).toList();
    return rooms;
  }

  void insertAll(List<RoomEntity> rooms) async{
    rooms.forEach((room) async {
      await database.insert(tableRoom, room.toMap());
    });
  }

  Future<int> insert(RoomEntity room) async {
    return await database.insert(tableRoom, room.toMap());
  }
}
