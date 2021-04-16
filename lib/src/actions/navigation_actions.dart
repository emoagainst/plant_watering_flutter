import 'package:plant_watering/src/actions/app_actions.dart';
import 'package:plant_watering/src/core/navigation.dart';

class NavigationItemChangedAction extends PlantWateringAppAction {
  final PlantWateringNavigationItem item;

  NavigationItemChangedAction({required this.item});

  @override
  String toString() {
    return 'NavigationItem{item: $item}';
  }
}