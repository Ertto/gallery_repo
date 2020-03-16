import 'package:flutter/material.dart';
import 'package:gallerymobi/pages/GalleryPG.dart';

void main() => runApp(GalleyApp());

class GalleyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Galley.mobi",
      theme: ThemeData(),
      home: GalleryPG(),
    );
  }
}
