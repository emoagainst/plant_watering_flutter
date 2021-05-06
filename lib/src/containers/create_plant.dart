import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:plant_watering/src/actions/plant_actions.dart';
import 'package:plant_watering/src/data/plant.dart';
import 'package:plant_watering/src/data/states.dart';
import 'package:plant_watering/src/data/room.dart';
import 'package:plant_watering/src/selectors/selectors.dart';
import 'package:redux/redux.dart';

import '../presentation/create_plant_screens.dart';

class CreatePlant extends StatelessWidget {
  final String title;

  const CreatePlant({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return CreatePlantScreen(title: title, rooms: vm.rooms, onSavePlant: vm.onSavePlant);
      },
    );
  }
}

class _ViewModel {
  final List<RoomData> rooms;
  final Function(PlantData) onSavePlant;

  _ViewModel({required this.rooms, required this.onSavePlant});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      rooms: roomsSelector(store.state.roomsState).toList(growable: false),
      onSavePlant: (plant) {
        store.dispatch(AddPlantAction(plant));
      },
    );
  }
}
