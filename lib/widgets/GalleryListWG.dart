import 'package:flutter/material.dart';
import 'package:gallerymobi/utils/ApiHendler.dart';
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
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    loadMore();
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

  Widget _builder(BuildContext context, int pos) {
    if (!this._loading && pos >= this._data.length - 3) {
      loadMore();
    }
    return GestureDetector(
      child: Image.network(
        _data[pos].thumb,
        fit: BoxFit.cover,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PhotoPG(_data[pos].full)),
        );
      },
    );
  }

  void loadMore() async {
    _loading = true;
    _page++;
    List<Photo> res = await _api.loadPhotos(_page);
    _loading = false;

    setState(() {
      _data.addAll(res);
    });
  }
}
