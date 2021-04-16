import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:plant_watering/src/core/routes.dart';
import 'package:plant_watering/src/data/plant.dart';

typedef OnInit = void Function();

class PlantsScreen extends StatefulWidget {
  final List<PlantData> plants;
  final bool isLoading;
  final OnInit onInit;

  PlantsScreen({Key? key, required this.plants, required this.isLoading, required this.onInit}) : super(key: key);

  @override
  _PlantsScreenState createState() => _PlantsScreenState();
}

class _PlantsScreenState extends State<PlantsScreen> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.plants.isEmpty
        ? _Empty()
        : widget.isLoading
            ? _Loading()
            : GridView.count(
                primary: false,
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: List.generate(widget.plants.length, (index) {
                  final _plant = widget.plants[index];
                  final title = "${_plant.name} ${_plant.room?.name ?? ''}";
                  return Builder(builder: (context) {
                    if (_plant.photoUrl?.isNotEmpty == true) {
                      return Center(
                        child: Stack(
                          children: [
                            SizedBox.expand(
                              child: Image.file(
                                File(_plant.photoUrl ?? ""),
                                fit: BoxFit.cover,
                                semanticLabel: title,
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                height: 48,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                decoration: BoxDecoration(color: Colors.black26),
                                child: Text(
                                  title,
                                  style: Theme.of(context).accentTextTheme.bodyText1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(title),
                      );
                    }
                  });
                }),
              );
  }
}

class _Empty extends StatelessWidget {
  void _onAddPlantPressed(BuildContext context) async {
    await Navigator.pushNamed(context, PlantWateringRoutes.addPlant);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => _onAddPlantPressed(context),
        child: Column(
          children: [
            Icon(
              Icons.add,
              size: 48,
            ),
            Divider(
              height: 16,
            ),
            Text(AppLocalizations.of(context)!.plantsScreenAddPlant),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
