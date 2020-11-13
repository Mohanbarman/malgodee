import 'package:ShoppingApp/models/category.dart';
import 'package:ShoppingApp/bloc/image_pick_bloc.dart';
import 'package:ShoppingApp/components/bottom_navigation_bar.dart';
import 'package:ShoppingApp/services/firebase_api.dart';
import 'package:ShoppingApp/shared/localstorage.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/components/app_bar.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:ShoppingApp/components/underlined_text.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ShoppingApp/components/buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';
import 'dart:io';

class EditCategory extends StatelessWidget {
  CategoryModel categoryModel;
  TextEditingController _titleController;
  TextEditingController _descriptionController;

  EditCategory({CategoryModel categoryModel}) {
    this.categoryModel = categoryModel;
    this._titleController = TextEditingController(text: categoryModel.name);
    this._descriptionController = TextEditingController(
      text: categoryModel.description,
    );

    pickedImageBloc.clear();

    LocalStorage.loadData(model: categoryModel).then(
      (bytes) => pickedImageBloc.imageBytesSink.add(bytes),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      // bottomNavigationBar: CustomBottomNavigationBar(null),
      body: ListView(
        shrinkWrap: true,
        children: [
          Title(),
          ImagePlaceholder(pickedImageBloc),
          SizedBox(height: 30),
          UploadButton(pickedImageBloc),
          SizedBox(height: 30),
          UploadDetailsForm(
            titleController: _titleController,
            descriptionController: _descriptionController,
            model: this.categoryModel,
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}

class UploadDetailsForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final model;

  UploadDetailsForm({
    this.titleController,
    this.descriptionController,
    this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenPadding * 1.5),
      child: Column(
        children: [
          Row(children: [Text('Category Title', style: AddFieldLabelStyle)]),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.symmetric(horizontal: ScreenPadding),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 40),
          Row(children: [
            Text('Category Description', style: AddFieldLabelStyle)
          ]),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.symmetric(horizontal: ScreenPadding),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: descriptionController,
              maxLines: 10,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HighlightedShadowButton(
                title: 'Save',
                fgColor: DefaultGreenColor,
                shadowColor: DefaultShadowGreenColor,
                onPressed: () {
                  _save().then(
                    (_) => Navigator.pushReplacementNamed(
                      context,
                      '/allcategories',
                    ),
                  );
                },
              ),
              HighlightedShadowButton(
                title: 'Delete',
                fgColor: DefaultRedColor,
                shadowColor: DefaultShadowRedColor,
                onPressed: () {
                  FirebaseStorageApi.deleteDoc(
                    id: model.id,
                    collection: 'categories',
                  )
                      .then(
                        (value) => Scaffold.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: DefaultRedColor,
                            content: Text('Deleting category'),
                          ),
                        ),
                      )
                      .then(
                        (value) => Navigator.pushReplacementNamed(
                          context,
                          '/allcategories',
                        ),
                      );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future _save() async {
    if (pickedImageBloc.cachedImageBytes != null &&
        pickedImageBloc.cachedImagePath != null) {
      print('this ran');
      var uuid = Uuid();
      var id = uuid.v1();
      print(pickedImageBloc.cachedImagePath);
      String filename =
          id.toString() + '.' + pickedImageBloc.cachedImagePath.split('.').last;
      await FirebaseStorageApi.uploadFile(
        file: File(pickedImageBloc.cachedImagePath),
        filename: filename,
      );
      await FirebaseStorageApi.updateDocument(
        model: CategoryModel(
          name: titleController.value.text,
          description: descriptionController.value.text,
          image: filename,
          id: model.id,
        ),
        collection: 'categories',
      );
    } else {
      await FirebaseStorageApi.updateDocument(
        model: CategoryModel(
          name: titleController.value.text,
          description: descriptionController.value.text,
          id: model.id,
          image: model.image,
        ),
        collection: 'categories',
      );
    }

    return true;
  }
}

class Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: ScreenPadding),
        child: Center(
          child: UnderlinedText('Edit category').noUnderline(),
        ),
      ),
    );
  }
}

class ImagePlaceholder extends StatelessWidget {
  final pickedImageBloc;
  ImagePlaceholder(this.pickedImageBloc);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: StreamBuilder(
        stream: pickedImageBloc.imageBytesStream,
        builder: (context, snapshot) {
          return Container(
            height: 200,
            width: 200,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: snapshot.hasData == false
                ? Center(
                    child: Text('No image selected',
                        style: PlaceholderTextAddItem),
                  )
                : Image.memory(
                    snapshot.data,
                    fit: BoxFit.cover,
                  ),
          );
        },
      ),
    );
  }
}

class UploadButton extends StatelessWidget {
  final pickedImageBloc;
  UploadButton(this.pickedImageBloc);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: SecondaryColorDropShadow,
                offset: Offset(5, 7),
                blurRadius: 20,
              ),
            ],
          ),
          child: RaisedButton.icon(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            onPressed: () {
              _pickImage().then(
                (value) async {
                  pickedImageBloc.imageBytesSink.add(await value.readAsBytes());
                  pickedImageBloc.imagePathSink.add(value.path);
                },
              );
            },
            color: SecondaryColor,
            label: Text('Select an image', style: UploadButtonTextStyle),
            icon: Icon(FeatherIcons.upload, color: Colors.white),
            elevation: 0,
          ),
        ),
      ),
    );
  }

  Future<PickedFile> _pickImage() async {
    return await ImagePicker().getImage(source: ImageSource.gallery);
  }
}