import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:plant_watering/src/actions/plant_actions.dart';
import 'package:plant_watering/src/data/plant.dart';
import 'package:plant_watering/src/data/states.dart';
import 'package:plant_watering/src/presentation/plants_screen.dart';
import 'package:plant_watering/src/selectors/selectors.dart';
import 'package:redux/redux.dart';

class Plants extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) => PlantsScreen(
        plants: vm.plants,
        isLoading: vm.isLoading,
        onInit: vm.onInit,
      ),
    );
  }
}

class _ViewModel {
  final List<PlantData> plants;
  final bool isLoading;
  final Function() onInit;

  _ViewModel({
    required this.plants,
    required this.isLoading,
    required this.onInit,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        isLoading: plantsLoadingSelector(store.state.plantsState),
        plants: plantsWithRoomSelector(plantsSelector(store.state.plantsState), roomsSelector(store.state.roomsState)),
        onInit: () {
          store.dispatch(PlantsLoadingRequestedAction());
        });
  }
}
