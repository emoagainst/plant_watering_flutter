import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:plant_watering/src/core/navigation.dart';
import 'package:plant_watering/src/data/plant_watering_app.dart';

class HomeBody extends StatelessWidget {
  final ViewModelBuilder<PlantWateringNavigationItem> builder;

  HomeBody({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PlantWateringNavigationItem>(
      converter: (store) => store.state.selectedNavigationItem,
      builder: builder,
    );
  }
}
