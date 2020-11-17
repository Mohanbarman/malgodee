import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum PreviewShape { circle, roundedRectangle }

class ImagePreview extends StatelessWidget {
  dynamic bloc;
  PreviewShape previewShape;
  ImagePreview({this.bloc, this.previewShape});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        height: 200,
        width: 200,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: previewShape == PreviewShape.circle
              ? BoxShape.circle
              : BoxShape.rectangle,
          borderRadius: previewShape == PreviewShape.roundedRectangle
              ? BorderRadius.circular(20)
              : null,
        ),
        child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            if (bloc.currPath.length < 1)
              return Center(child: Text('No image selected'));

            if (bloc.currPath.contains('https://')) {
              print('This ran');
              return CachedNetworkImage(
                imageUrl: bloc.currPath,
                fit: BoxFit.cover,
              );
            }
            return Image.file(File(bloc.currPath), fit: BoxFit.cover);
          },
        ),
      ),
    );
  }
}
