import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:plant_watering/src/core/widget_keys.dart';
import 'package:plant_watering/src/data/room.dart';

typedef OnSaveRoomCallback = void Function(RoomData roomData);

class CreateRoomField extends StatelessWidget {
  final OnSaveRoomCallback onSaveRoom;
  final RoomData _room = RoomData.initial();

  CreateRoomField({required this.onSaveRoom});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
      child: Form(
        key: _formKey,
        child: TextFormField(
            key: PlantWateringKeys.roomNameField,
            textInputAction: TextInputAction.next,
            autofocus: true,
            decoration: InputDecoration(
              icon: Icon(Icons.edit),
              filled: true,
              hintText: AppLocalizations.of(context)!.roomNameHint,
              labelText: AppLocalizations.of(context)!.roomNameLabel,
            ),
            keyboardType: TextInputType.name,
            onEditingComplete: () {
              _formKey.currentState!.save();
              onSaveRoom(_room);
              Navigator.maybePop(context);
            },
            onSaved: (value) {
              print("onSaved room $value");
              _room.name = value ?? "";
            },
          ),
        ),
    );
  }
}
