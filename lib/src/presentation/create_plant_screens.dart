import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:plant_watering/src/core/widget_keys.dart';
import 'package:plant_watering/src/data/room.dart';
import 'package:plant_watering/src/data/watering.dart';
import 'package:plant_watering/src/presentation/add_plant_photo_widget.dart';

import '../data/plant.dart';

typedef OnSavePlantCallback = void Function(PlantData plantData);

class CreatePlantScreen extends StatelessWidget {
  final OnSavePlantCallback onSavePlant;
  final List<RoomData> rooms;
  final String title;

  CreatePlantScreen({
    Key? key,
    required this.title,
    required this.rooms,
    required this.onSavePlant,
  }) : super(key: key ?? PlantWateringKeys.addPlantScreen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: CreatePlantForm(
        rooms: rooms,
        onSavePlant: onSavePlant,
      ),
    );
  }
}

// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

class CreatePlantForm extends StatefulWidget {
  final OnSavePlantCallback onSavePlant;
  final List<RoomData> rooms;

  const CreatePlantForm({
    Key? key,
    required this.rooms,
    required this.onSavePlant,
  }) : super(key: key);

  @override
  _CreatePlantFormState createState() => _CreatePlantFormState();
}

class _CreatePlantFormState extends State<CreatePlantForm> {
  PlantData _plant = PlantData.initial();
  RoomData? _selectedRoom;


  late FocusNode _name, _location, _description;

  @override
  void initState() {
    super.initState();
    _name = FocusNode();
    _location = FocusNode();
    _description = FocusNode();
  }

  @override
  void dispose() {
    _name.dispose();
    _location.dispose();
    _description.dispose();
    super.dispose();
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(value),
    ));
  }

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handlePhotoAdded(String photoUri) {
    _plant.photoUrl = photoUri;
  }

  void _handleSaveRequested() {
    final form = _formKey.currentState!;
    if (!form.validate()) {
      _autoValidateMode = AutovalidateMode.always; // Start validating on every change.
      showInSnackBar(AppLocalizations.of(context)!.createPlantFormError);
    } else {
      form.save();
      _plant.room = _selectedRoom;
      widget.onSavePlant(_plant);
    }
  }

  String? _validate(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.emptyFieldValidationError;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 24, width: 24);

    return Form(
      key: _formKey,
      autovalidateMode: _autoValidateMode,
      child: Scrollbar(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  child: TextFormField(
                    key: PlantWateringKeys.plantNameField,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      filled: true,
                      icon: const Icon(Icons.add_photo_alternate_sharp),
                      hintText: AppLocalizations.of(context)!.plantNameHint,
                      labelText: AppLocalizations.of(context)!.plantNameLabel,
                    ),
                    onSaved: (value) {
                      _plant.name = value ?? "";
                      _location.requestFocus();
                    },
                    validator: _validate,
                  ),
                ),
                sizedBoxSpace,
                AddPlantPhoto(onAddPlantPhoto: _handlePhotoAdded),
              ],
            ),
            sizedBoxSpace,
            InputDecorator(
              decoration: InputDecoration(
                filled: true,
                icon: const Icon(Icons.room),
                contentPadding: EdgeInsets.fromLTRB(12, 4, 12, 4),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<RoomData>(
                  isExpanded: true,
                  hint: Text(AppLocalizations.of(context)!.plantLocationHint),
                  value: _selectedRoom,
                  items: widget.rooms
                      .map((room) => DropdownMenuItem<RoomData>(
                            child: Text(room.name ?? ""),
                            value: room,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedRoom = value;
                    });
                  },
                ),
              ),
            ),
            sizedBoxSpace,
            TextFormField(
              key: PlantWateringKeys.plantDescriptionField,
              textInputAction: TextInputAction.next,
              focusNode: _description,
              decoration: InputDecoration(
                icon: Icon(Icons.edit),
                filled: true,
                hintText: AppLocalizations.of(context)!.plantDescriptionHint,
                labelText: AppLocalizations.of(context)!.plantDescriptionLabel,
              ),
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) {
                _plant.description = value;
              },
            ),
            sizedBoxSpace,
            Container(
              child: Align(
                alignment: Alignment.centerRight,
                child: Builder(
                  builder: (BuildContext context) {
                    return ElevatedButton(
                      key: PlantWateringKeys.createPlantButton,
                      child: Text(AppLocalizations.of(context)!.nextPlantButtonText),
                      onPressed: _handleSaveRequested,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
