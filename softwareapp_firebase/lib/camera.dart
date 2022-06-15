import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatelessWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  fotoCek() async {
    //yukarıda açılan showDialog penceresinin kapanması için
    var image = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 800, //fotonun max eni
      maxHeight: 600, //fotonun max yuksekigi
      imageQuality: 80, //dosya boyutunu azaltmak için resim kalitesini düşürür.
    );
  }
}
