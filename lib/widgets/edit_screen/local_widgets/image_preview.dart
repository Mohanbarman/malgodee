import 'dart:io';
import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  dynamic bloc;
  ImagePreview({this.bloc});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: StreamBuilder(
        stream: bloc.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: Text('No image selected'));
          return Image.file(File(snapshot.data), fit: BoxFit.cover);
        },
      ),
    );
  }
}
