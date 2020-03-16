import 'package:flutter/material.dart';
import 'package:gallerymobi/widgets/GalleryListWG.dart';

class GalleryPG extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery"),
      ),
      body: GalleryListWG(),
    );
  }
}
