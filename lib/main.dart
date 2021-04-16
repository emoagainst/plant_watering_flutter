import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:plant_watering/src/db/database.dart';
import 'package:plant_watering/src/db/plant.dart';
import 'package:plant_watering/src/db/room.dart';
import 'package:plant_watering/src/middleware/plants_db_middleware.dart';
import 'package:plant_watering/src/middleware/rooms_db_middleware.dart';
import 'package:redux/redux.dart';

import 'src/app.dart';
import 'src/data/plant_watering_app.dart';
import 'src/reducers/app_reducers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await createDatabase();

  final roomDao = RoomDao(database);
  final plantDao = PlantDao(database);

  final store = Store<AppState>(
    appReducer,
    initialState: AppState(),
    middleware: createPlantsDbMiddleware(plantDao) + createRoomsDbMiddleware(roomDao),
  );

  runApp(
    MyApp(
      store: store,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    ),
  );
}
