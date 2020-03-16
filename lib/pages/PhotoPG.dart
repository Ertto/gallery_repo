import 'package:flutter/material.dart';

class PhotoPG extends StatelessWidget {
  final String _photo;

  PhotoPG(this._photo, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo"),
      ),
      body: Image.network(
        this._photo,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
