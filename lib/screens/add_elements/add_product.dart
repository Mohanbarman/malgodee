import 'package:ShoppingApp/widgets/bottom_navigation_bar.dart';
import 'package:ShoppingApp/widgets/shimmer_placeholders.dart';
import 'package:ShoppingApp/models/product.dart';
import 'package:ShoppingApp/services/firebase_api.dart';
import 'package:ShoppingApp/shared/localstorage.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ShoppingApp/widgets/underlined_text.dart';
import 'package:ShoppingApp/widgets/app_bar.dart';
import 'package:ShoppingApp/widgets/buttons.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';
import 'dart:io';

class AddProduct extends StatelessWidget {
  AddProductBloc _addProductBloc = AddProductBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(null),
      body: ListView(
        shrinkWrap: true,
        children: [
          Title(),
          Padding(
            padding: const EdgeInsets.all(ScreenPadding),
            child: Text('Product Image', style: AddFieldLabelStyle),
          ),
          ImageRow(bloc: _addProductBloc),
          SizedBox(height: 30),
          UploadDetailsForm(bloc: _addProductBloc),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}

class UploadDetailsForm extends StatefulWidget {
  AddProductBloc bloc;
  UploadDetailsForm({this.bloc});

  @override
  _UploadDetailsFormState createState() =>
      _UploadDetailsFormState(bloc: this.bloc);
}

class _UploadDetailsFormState extends State<UploadDetailsForm> {
  String dropdownValue;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  AddProductBloc bloc;

  _UploadDetailsFormState({this.bloc});

  List<String> categories = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenPadding * 1.5),
      child: Column(
        children: [
          StreamBuilder(
            stream: FirebaseStorageApi.streamOfCollection(
              collection: 'brands',
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return TextInputShimmer();
              return DropdownButton(
                value: dropdownValue,
                items: snapshot.data.docs
                    .toList()
                    .map(
                      (e) {
                        print(e.id);
                        return DropdownMenuItem<String>(
                          child: Text(e['name']),
                          value: e.id,
                        );
                      },
                    )
                    .toList()
                    .cast<DropdownMenuItem<String>>(),
                onChanged: (String value) {
                  setState(() {
                    dropdownValue = value;
                    print('selected : $value');
                  });
                },
              );
            },
          ),
          StreamBuilder(
              stream: FirebaseStorageApi.streamOfCollection(
                collection: 'categories',
              ),
              builder: (context, snapshot) {
                return MultiSelect(
                  autovalidate: true,
                  titleText: 'title',
                  validator: (value) {
                    if (value == null) {
                      return 'Please select one or more option(s)';
                    }
                    this.categories = value.cast<String>();
                  },
                  errorText: 'Please select one or more option(s)',
                  dataSource: snapshot.data.docs
                      .toList()
                      .map(
                        (e) => {
                          'value': e.id,
                          'display': e['name'],
                        },
                      )
                      .toList(),
                  textField: 'display',
                  valueField: 'value',
                  filterable: true,
                  required: true,
                );
              }),
          SizedBox(height: 15),
          Row(children: [Text('Product Title', style: AddFieldLabelStyle)]),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.symmetric(horizontal: ScreenPadding),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 40),
          Row(children: [
            Text('Product Description', style: AddFieldLabelStyle)
          ]),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.symmetric(horizontal: ScreenPadding),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              controller: _descriptionController,
              maxLines: 8,
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
                onPressed: _save,
              ),
              HighlightedShadowButton(
                title: 'Cancel',
                fgColor: DefaultRedColor,
                shadowColor: DefaultShadowRedColor,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _save() {
    print(bloc.path);
    List<String> uploadedPaths = [];
    bloc.path.forEach((element) async {
      var uuid = Uuid();
      String filenameuuid = uuid.v1();
      String filename = '$filenameuuid.${element.split('.').last}';
      uploadedPaths.add(filename);
      FirebaseStorageApi.uploadFile(
        file: File(element),
        filename: filename,
      );
    });

    FirebaseStorageApi.addData(
      collection: 'products',
      data: ProductModel(
        name: _titleController.value.text,
        description: _descriptionController.value.text,
        images: uploadedPaths,
        categories: categories,
        brand: dropdownValue,
      ).toJson(),
    ).then((value) => print('product added'));
  }
}

class Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(ScreenPadding),
        child: UnderlinedText('Add product').noUnderline(),
      ),
    );
  }
}

class ImageRow extends StatelessWidget {
  AddProductBloc bloc;
  ImageRow({this.bloc});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: StreamBuilder(
        stream: bloc.stream,
        builder: (context, snapshot) {
          int itemCount = bloc.path.length + 1;
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
                    imagePickerButton(),
                    SizedBox(width: ScreenPadding),
                  ],
                );
              }
              return Row(
                children: [
                  SizedBox(width: ScreenPadding),
                  Container(
                    height: 200,
                    width: 200,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Image.file(
                      File(bloc.path[index]),
                      fit: BoxFit.cover,
                    ),
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
        LocalStorage.pickImage().then(
          (value) => bloc.add(value.path),
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

class AddProductBloc {
  StreamController<String> _controller = StreamController<String>.broadcast();
  List<String> path = [];

  void add(String path) {
    _controller.sink.add(path);
  }

  get stream => _controller.stream;

  AddProductBloc() {
    _controller.stream.listen((e) {
      path.add(e);
      print('added : $e');
      print('current list : $path');
    });
  }

  void dispose() {
    _controller.close();
  }
}
