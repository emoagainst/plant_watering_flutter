import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:plant_watering/src/core/navigation.dart';
import 'package:plant_watering/src/core/routes.dart';
import 'package:plant_watering/src/data/states.dart';

class HomeFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      converter: (store) => store.state.plantsState.plants.isNotEmpty && store.state.selectedNavigationItem == PlantWateringNavigationItem.plants,
      builder: (context, shouldShow) {
        return shouldShow
            ? FloatingActionButton(
                onPressed: () { Navigator.pushNamed(context, PlantWateringRoutes.addPlant);},
                child: const Icon(Icons.add),
              )
            : SizedBox.shrink();
      },
    );
  }
}
