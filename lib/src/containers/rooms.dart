import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:plant_watering/src/actions/room_actions.dart';
import 'package:plant_watering/src/data/states.dart';
import 'package:plant_watering/src/data/room.dart';
import 'package:plant_watering/src/presentation/rooms_screen.dart';
import 'package:plant_watering/src/selectors/selectors.dart';
import 'package:redux/redux.dart';

class Rooms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) => RoomsScreen(
        roomsWithPlants: vm.roomsWithPlants,
        isLoading: vm.isLoading,
        onInit: vm.onInit,
      ),
    );
  }
}

class _ViewModel {
  final List<RoomWithPlantsData> roomsWithPlants;
  final bool isLoading;
  final Function() onInit;

  _ViewModel({
    required this.roomsWithPlants,
    required this.isLoading,
    required this.onInit,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        roomsWithPlants: roomWithPlantsSelector(roomsSelector(store.state.roomsState), plantsSelector(store.state.plantsState)),
        isLoading: roomsLoadingSelector(store.state.roomsState),
        onInit: () {
          store.dispatch(RoomsLoadingRequestedAction());
        });
  }
}
