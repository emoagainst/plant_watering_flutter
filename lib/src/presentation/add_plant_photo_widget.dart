import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

typedef OnAddPlantPhotoCallback = void Function(String photoUri);

class AddPlantPhoto extends StatefulWidget {
  final OnAddPlantPhotoCallback onAddPlantPhoto;
  
  AddPlantPhoto({Key? key, required this.onAddPlantPhoto});

  @override
  State<StatefulWidget> createState() => AddPlantPhotoState();
}

class AddPlantPhotoState extends State<AddPlantPhoto> {
  final ImagePicker _picker = ImagePicker();
  String? _photoUri;

  Future<void> _handleOpenCamera() async {
    final filePath = await _picker.getImage(source: ImageSource.camera);
    final photoUri = filePath?.path;
    if (photoUri == null){
      return ;
    }
    print("camera file: $photoUri");
    setState(() {
      _photoUri = photoUri;
    });

    widget.onAddPlantPhoto(photoUri);
  }

  Future<void> _handleOpenGallery() async {
    final filePath = await _picker.getImage(source: ImageSource.gallery);
    final photoUri = filePath?.path;
    if (photoUri == null){
      return ;
    }
    print("gallery file: $photoUri");
    setState(() {
      _photoUri = photoUri;
    });

    widget.onAddPlantPhoto(photoUri);
  }

  void _handleAddPhoto() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              ListTile(
                title: Text(AppLocalizations.of(context)!.addPlantPhotoChooseSource),
              ),
              ListTile(
                leading: Icon(Icons.camera),
                title: Text(AppLocalizations.of(context)!.addPlantPhotoOpenCamera),
                onTap: () async {
                  Navigator.pop(context);
                  await _handleOpenCamera();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text(AppLocalizations.of(context)!.addPlantPhotoOpenGallery),
                onTap: () async {
                  Navigator.pop(context);
                  _handleOpenGallery();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 96,
        height: 96,
        child: Builder(
          builder: (context) {
            if (_photoUri?.isNotEmpty == true) {
              return Image.file(
                  File(_photoUri!),
                  fit: BoxFit.cover,
                semanticLabel: AppLocalizations.of(context)!.addPlantPhotoSemanticLabel,
                );
            } else {
              return OutlinedButton(
                onPressed: _handleAddPhoto,
                child: Text(
                  AppLocalizations.of(context)!.addPlantPhotoButton,
                  textAlign: TextAlign.center,
                ),
              );
            }
          },
        ));
  }
}
