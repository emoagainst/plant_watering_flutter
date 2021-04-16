import 'package:flutter/material.dart';
import 'package:plant_watering/src/containers/home_body.dart';
import 'package:plant_watering/src/containers/home_fab.dart';
import 'package:plant_watering/src/containers/navigation_item_selector.dart';
import 'package:plant_watering/src/containers/plants.dart';
import 'package:plant_watering/src/containers/rooms.dart';
import 'package:plant_watering/src/core/navigation.dart';
import 'package:plant_watering/src/presentation/calendar_screen.dart';

class HomeScreen extends StatefulWidget {
  final String title;


  HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> pages = <Widget>[
    Plants(),
    WateringCalendar(),
    Rooms(),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: HomeBody(
          builder : (context, navItem) {
            return IndexedStack(
              index: PlantWateringNavigationItem.values.indexOf(navItem),
              children: pages,
            );
          }
      ),
      bottomNavigationBar: NavigationItemSelector(),
      floatingActionButton: HomeFab(),
    );
  }
}