import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:plant_watering/src/actions/navigation_actions.dart';
import 'package:plant_watering/src/core/navigation.dart';
import 'package:plant_watering/src/data/plant_watering_app.dart';
import 'package:plant_watering/src/selectors/selectors.dart';
import 'package:redux/redux.dart';

class NavigationItemSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        print("We redraw BottomNavigationBar");
        return BottomNavigationBar(
          items: PlantWateringNavigationItem.values.map((item) => BottomNavigationBarItem(
                icon: item.icon,
                label: item.label(context),
              )).toList(),
          currentIndex: PlantWateringNavigationItem.values.indexOf(vm.item),
          onTap: vm.onNavigationItemSelected,
        );
      },
    );
  }
}

class _ViewModel {
  final PlantWateringNavigationItem item;
  final Function(int) onNavigationItemSelected;

  _ViewModel({required this.item, required this.onNavigationItemSelected});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      item: navigationSelector(store.state),
      onNavigationItemSelected: (index) {
        store.dispatch(NavigationItemChangedAction(item: PlantWateringNavigationItem.values[index]));
      },
    );
  }
}
