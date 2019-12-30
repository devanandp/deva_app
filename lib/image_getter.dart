import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Imagepicker extends StatefulWidget {
  @override
  _ImagepickerState createState() => _ImagepickerState();
}

class _ImagepickerState extends State<Imagepicker> {
  Future<File> imageFile;

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'You will be appeared here :-)',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Picker"),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Center(
              child: RaisedButton(
                child: Text("Pick Image from Camera"),
                onPressed: () {
                  pickImageFromGallery(ImageSource.camera);
                },
              ),
            ),
            showImage(),
          ],
        ),
      ),
    );
  }
}
