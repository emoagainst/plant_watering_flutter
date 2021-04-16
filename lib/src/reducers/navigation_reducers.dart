import 'package:plant_watering/src/actions/navigation_actions.dart';
import 'package:plant_watering/src/core/navigation.dart';

PlantWateringNavigationItem navigationReducer(PlantWateringNavigationItem navigationItem, action){
  if (action is NavigationItemChangedAction){
    return action.item;
  }

  return navigationItem;
}