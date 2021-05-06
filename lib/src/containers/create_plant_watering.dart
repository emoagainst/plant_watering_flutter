import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:plant_watering/src/actions/watering_actions.dart';
import 'package:plant_watering/src/data/plant.dart';
import 'package:plant_watering/src/data/states.dart';
import 'package:plant_watering/src/data/watering.dart';
import 'package:plant_watering/src/presentation/create_plant_watering_screen.dart';
import 'package:plant_watering/src/selectors/selectors.dart';
import 'package:redux/redux.dart';

class CreatePlantWatering extends StatelessWidget {
  final String title;

  const CreatePlantWatering({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final plantId = ModalRoute
        .of(context)!
        .settings
        .arguments as int;
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, plantId),
      builder: (context, vm) {
        return CreatePlantWateringScreen(title: title, onSaveWatering: vm.onSaveWatering);
      },
    );
  }
}

class _ViewModel {
  final PlantData? plant;
  final Function(WateringData) onSaveWatering;

  _ViewModel({required this.plant, required this.onSaveWatering});

  static _ViewModel fromStore(Store<AppState> store, int plantId) {
    return _ViewModel(
      plant: plantSelector(store.state.plantsState, plantId),
      onSaveWatering: (watering) {
        final plant = plantSelector(store.state.plantsState, plantId);
        if (plant != null) {
          watering.plant = plant;
        }
        store.dispatch(AddWateringAction(watering));
      },
    );
  }
}
