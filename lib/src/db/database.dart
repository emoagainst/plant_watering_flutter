// required package imports
import 'dart:async';

import 'package:path/path.dart';
import 'package:plant_watering/src/db/plant.dart';
import 'package:plant_watering/src/db/room.dart';
import 'package:plant_watering/src/db/watering.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() async {
  Database db = await openDatabase(
    join(await getDatabasesPath(), 'pwdatabase.db'), //db path
    onCreate: (db, version) async {
      //Create Tables section
      await db.execute(RoomEntity.CREATE_TABLE);
      await db.execute(PlantEntity.CREATE_TABLE);
      await db.execute(WateringEntity.CREATE_TABLE);

      //Insert predefined values section
      await db.execute(RoomEntity.INSERT_PREDEFINED);
    },
    version: 1,
  );
  return db;
}