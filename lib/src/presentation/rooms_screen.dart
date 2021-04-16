import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:plant_watering/src/containers/create_room.dart';
import 'package:plant_watering/src/data/room.dart';

typedef OnInit = Function();

class RoomsScreen extends StatefulWidget {
  final List<RoomWithPlantsData> roomsWithPlants;
  final bool isLoading;
  final OnInit onInit;

  const RoomsScreen({Key? key, required this.roomsWithPlants, required this.isLoading, required this.onInit}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RoomsScreenState();
  }
}

class _RoomsScreenState extends State<RoomsScreen> {
  bool _onAddRoomRequested = false;


  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  Future<bool> _onWillPop() async {
    final isAddRoomOpened = _onAddRoomRequested;
    setState(() => {_onAddRoomRequested = false});
    return !isAddRoomOpened;
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = widget.roomsWithPlants.length + 1;
    return
      widget.isLoading ?
      _Loading()
      : ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (_onAddRoomRequested && index == itemCount - 1) {
          return WillPopScope(
            child: CreateRoom(),
            onWillPop: _onWillPop,
          );
        }
        if (index == itemCount - 1) {
          return ListTile(
            title: Text(AppLocalizations.of(context)!.roomScreenAddRoom),
            leading: Icon(Icons.add),
            onTap: () => {
              setState(() => {_onAddRoomRequested = true})
            },
          );
        }
        final room = widget.roomsWithPlants[index].room;
        final plants = widget.roomsWithPlants[index].plants;
        return ListTile(
          title: Text(room.name ?? ""),
          trailing: SizedBox(
            width: 136,
            height: 32,
            child: ListView.separated(
              itemBuilder: (context, index) => SizedBox(
                width: 32,
                height: 32,
                child: Builder(
                  builder: (context) {
                    final photoUri = plants[index].photoUrl;
                    if (photoUri?.isNotEmpty == true) {
                      return Image.file(
                        File(photoUri!),
                        fit: BoxFit.cover,
                      );
                    } else {
                      return Icon(
                        Icons.photo,
                      );
                    }
                  },
                ),
              ),
              separatorBuilder: (context, index) => VerticalDivider(),
              itemCount: min(plants.length, 3),
              scrollDirection: Axis.horizontal,
              reverse: true,
            ),
          ),
        );
      },
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
