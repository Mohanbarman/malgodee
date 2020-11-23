import 'dart:io';
import 'package:ShoppingApp/utils/pick_image.dart';
import 'package:ShoppingApp/widgets/crud_form/utils/multiple_image_pick_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class ImageRow extends StatelessWidget {
  MultipleImagePickBloc bloc;

  ImageRow({this.bloc});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: StreamBuilder(
        stream: bloc.stream,
        builder: (context, snapshot) {
          int itemCount = bloc.paths.length + 1;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: itemCount,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              if (index + 1 == itemCount) {
                return Row(
                  children: [
                    SizedBox(width: ScreenPadding),
                    Column(
                      children: [
                        imagePickerButton(),
                        Container(height: 50),
                      ],
                    ),
                    SizedBox(width: ScreenPadding),
                  ],
                );
              }
              return Row(
                children: [
                  SizedBox(width: ScreenPadding),
                  Column(
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Image(
                          image: FileImage(File(bloc.paths[index])),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(height: 10),
                      FlatButton(
                        onPressed: () {
                          bloc.remove(bloc.paths[index]);
                          bloc.add(true);
                        },
                        color: DefaultRedColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Remove',
                              style: TextStyle(color: Colors.white),
                            ),
                            Container(width: 10),
                            Icon(Icons.delete_forever, color: Colors.white),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget imagePickerButton() {
    return GestureDetector(
      onTap: () {
        pickImage().then(
          (value) => bloc.add(value),
        );
      },
      child: Container(
        height: 200,
        width: 200,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            Center(
              child: Icon(
                FeatherIcons.upload,
                size: 70,
                color: DefaultGreenColor,
              ),
            ),
            Positioned(
              bottom: 15,
              child: Container(
                width: 200,
                child: Center(
                  child: Text(
                    '900x900',
                    style: PlaceholderTextAddItem,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
