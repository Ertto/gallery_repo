import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:gallerymobi/utils/ApiHendler.dart';
import 'package:gallerymobi/utils/LoadState.dart';
import 'package:gallerymobi/utils/Photo.dart';
import 'package:gallerymobi/pages/PhotoPG.dart';

class GalleryListWG extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GalleryListWGState();
  }
}

class GalleryListWGState extends State<GalleryListWG> {
  ApiHandler _api = ApiHandler("https://api.unsplash.com/",
      "cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0");
  List<Photo> _data = [];
  int _page = 1;
  LoadState _loadState = LoadState.ready;
  StreamSubscription changeConnection;


  @override
  void initState() {
    super.initState();

    changeConnection = Connectivity().onConnectivityChanged.listen(_connectListener);

    this._loadMore();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: _builder,
      itemCount: _data.length,
    );
  }

  @override
  void dispose() {
    changeConnection.cancel();
    super.dispose();
  }

  Widget _builder(BuildContext context, int pos) {
    if (this._loadState == LoadState.ready && pos >= this._data.length - 3) {
      this._loadMore();
    }
    return GestureDetector(
      child: Image(
        image: NetworkImageWithRetry(this._data[pos].thumb),
        fit: BoxFit.cover,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PhotoPG(this._data[pos].full)),
        );
      },
    );
  }

  void _loadMore() async {
    List<Photo> res;
    this._loadState = LoadState.loading;

    try {
      res = await _api.loadPhotos(_page);
    } catch (e) {
      this._loadState = LoadState.error;
      return;
    }

    this._page++;
    this._loadState = LoadState.ready;
    setState(() {
      this._data.addAll(res);
    });
  }

  void _connectListener(ConnectivityResult result) {
    if (this._loadState == LoadState.error && result != ConnectivityResult.none) {
      this._loadMore();
    }
  }

}