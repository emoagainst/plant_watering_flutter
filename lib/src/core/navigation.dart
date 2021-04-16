import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum PlantWateringNavigationItem {
  plants, calendar, rooms
}

extension PlantWateringNavigationItemExt on PlantWateringNavigationItem {
  Icon get icon {
    switch (this) {
      case PlantWateringNavigationItem.plants : return Icon(Icons.grain);
      case PlantWateringNavigationItem.calendar : return Icon(Icons.calendar_today);
      case PlantWateringNavigationItem.rooms : return Icon(Icons.account_tree_outlined);
      default: throw Exception("Can not get icon of $this");
    }
  }

  String label(BuildContext context) {
    switch (this) {
      case PlantWateringNavigationItem.plants : return AppLocalizations.of(context)!.navigationItemPlants;
      case PlantWateringNavigationItem.calendar : return AppLocalizations.of(context)!.navigationItemCalendar;
      case PlantWateringNavigationItem.rooms : return AppLocalizations.of(context)!.navigationItemRooms;
      default: throw Exception("Can not get label of $this");
    }
  }
}