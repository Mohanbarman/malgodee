import 'dart:io';
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
            if (!snapshot.hasData)
              return Center(child: Text('No image selected'));
            return Image.file(File(snapshot.data), fit: BoxFit.cover);
          },
        ),
      ),
    );
  }
}
