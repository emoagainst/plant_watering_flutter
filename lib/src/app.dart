import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:plant_watering/src/core/routes.dart';
import 'package:plant_watering/src/presentation/create_plant_watering_screen.dart';
import 'package:redux/redux.dart';

import '../main.dart';
import 'containers/create_plant.dart';
import 'containers/create_plant_watering.dart';
import 'data/states.dart';
import 'presentation/home_screen.dart';

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final Iterable<Locale> supportedLocales;

  const MyApp({
    Key? key,
    required this.store,
    required this.localizationsDelegates,
    required this.supportedLocales,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
          localizationsDelegates: localizationsDelegates,
          supportedLocales: supportedLocales,
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          navigatorKey: navigatorKey,
          routes: {
            PlantWateringRoutes.home: (context) {
              return HomeScreen(title: AppLocalizations.of(context)!.homeScreenTitle);
            },
            PlantWateringRoutes.addPlant: (context) {
              return CreatePlant(title: AppLocalizations.of(context)!.createPlantScreenTitle);
            },
            PlantWateringRoutes.addPlantWatering: (context) {
              return CreatePlantWatering(title: AppLocalizations.of(context)!.createPlantWateringScreenTitle);
            }
          },
        ));
  }
}
