import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:plant_watering/src/core/widget_keys.dart';
import 'package:plant_watering/src/data/watering.dart';

typedef OnSaveWateringCallback = void Function(WateringData wateringData);

class CreatePlantWateringScreen extends StatefulWidget {
  final OnSaveWateringCallback onSaveWatering;
  final String title;

  const CreatePlantWateringScreen({
    Key? key,
    required this.title,
    required this.onSaveWatering,
  }) : super(key: key);

  @override
  _CreatePlantWateringScreenState createState() => _CreatePlantWateringScreenState();
}

class _CreatePlantWateringScreenState extends State<CreatePlantWateringScreen> {
  WateringData _watering = WateringData.initial();
  DateTime? _lastWateringDate;

  late FocusNode _wateringPeriod, _wateringLastDate;
  @override
  void initState() {
    super.initState();
    _wateringPeriod = FocusNode();
    _wateringLastDate = FocusNode();
  }

  @override
  void dispose() {
    _wateringPeriod.dispose();
    _wateringLastDate.dispose();
    super.dispose();
  }

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleSaveRequested() {
    final form = _formKey.currentState!;
    if (!form.validate()) {
      _autoValidateMode = AutovalidateMode.always; // Start validating on every change.
      showInSnackBar(AppLocalizations.of(context)!.createPlantFormError);
    } else {
      form.save();
      widget.onSaveWatering(_watering);
    }
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(value),
    ));
  }

  String? _validateWateringPeriod(String? value) {
    if ((value == null || value.isEmpty)) {
      return null;
    }
    final period = int.tryParse(value);
    if (period == null) {
      return AppLocalizations.of(context)!.numFieldFormatValidationError;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 24, width: 24);



    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          autovalidateMode: _autoValidateMode,
          child: Scrollbar(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              children: [
                TextFormField(
                  key: PlantWateringKeys.plantWateringPeriodField,
                  textInputAction: TextInputAction.next,
                  focusNode: _wateringPeriod,
                  decoration: InputDecoration(
                    icon: Icon(Icons.timelapse),
                    filled: true,
                    hintText: AppLocalizations.of(context)!.plantWateringPeriodHint,
                    labelText: AppLocalizations.of(context)!.plantWateringPeriodLabel,
                  ),
                  keyboardType: TextInputType.number,
                  validator: _validateWateringPeriod,
                  onSaved: (value) {
                    if (value != null && value.isNotEmpty) {
                      _watering.periodInDays = int.tryParse(value) ?? -1;
                    }
                  },
                ),
                sizedBoxSpace,
                InputDecorator(
                  decoration: InputDecoration(
                    filled: true,
                    hintText: AppLocalizations.of(context)!.plantWateringLastDayHint,
                  ),
                  child: TextButton(
                    child: Text(_lastWateringDate?.toString() ?? AppLocalizations.of(context)!.plantWateringLastDayLabel),
                    onPressed: () async {
                      final now = DateTime.now();
                      final firstDate = DateTime(now.year - 1, now.month, now.day);
                      final selectedDate = await showDatePicker(context: context, initialDate: now, firstDate: firstDate, lastDate: now);
                      if (selectedDate != null) {
                        setState(() {
                          _lastWateringDate = selectedDate;
                        });
                        _watering.lastWateringDate = selectedDate;
                      }
                    },
                  ),
                ),
                sizedBoxSpace,
                Container(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Builder(
                      builder: (BuildContext context) {
                        return ElevatedButton(
                          key: PlantWateringKeys.createPlantWateringButton,
                          child: Text(AppLocalizations.of(context)!.createPlantButtonText),
                          onPressed: _handleSaveRequested,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
